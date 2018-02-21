---
documentclass: ltjarticle
title: "Swaggerの導入手順"
output: pdf_document
---

***

SwaggerはAPIなどの仕様をまとめるためのフレームワーク  
Swagger-blockは，RubyでOpenAPI形式の仕様をJSON形式に変換可能な形で定義可能にするDSL
swagger_ui_engineは，swagger-blocksで生成した仕様をのwebから閲覧可能にするもの．

```ruby
# Gemfile
gem 'swagger-blocks'
gem 'swagger_ui_engine'
```


***
## swagger-blocksの設定  
詳細は[swagger-blocksのGithub](https://github.com/fotinakis/swagger-blocks)または[OpenAPI2.0の仕様詳細](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md)を参照すること

### アプリケーションの仕様
**ディレクトリ:** *app/controllers/api/v1/*
```Ruby
# app/controllers/api/v1/swagger_controller.rb
module Api::V1
  class SwaggerController < ActionController::Base
    include SwaggerBlocks

    swagger_root do
      key :swagger, '2.0'
      info do
        key :title, 'sample_api' # タイトル
        key :version, '0.0.1' # バージョン
        key :termsOfService, 'TODO: type URL' # 利用規約
      end
      key :consumes, ['application/json']
      key :produces, ['application/json']

      security_definition :api_key do
        key :type, :apiKey
        key :name, :Authorization
        key :in, :header
      end

      security do
        key :api_key, []  
      end
    end

    SWAGGER_CLASSES = [
      self,
    ].freeze

    def index
      render json: Swagger::Blocks.build_root_json(SWAGGER_CLASSES)
    end
  end
end

```
基本的には各エンドポイントの仕様をここに書いていっても構わない．  
しかしパラメータの重複など，仕様変更があった時の影響範囲を把握しやすくするためにも，cconcernsの中に仕様を書いてここからincludeする形を取れば，SWAGGER_CLASSESもselfのみで良くなる．
以下はconcernの中に仕様をまとめる形で書いている．

### コントローラの仕様
**ディレクトリ:** *app/controllers/concerns/swagger/v1/*
各エンドポイント毎のパラメータ,HTTPステータスごとのレスポンスの仕様を定義する．
```Ruby
# app/controllers/concerns/swagger/v1/location_api.rb
# addresses_controllerのApi_doc
module Swagger::V1::LocationsApi
  extend ActiveSupport::Concern
  include Swagger::ErrorSchema
  include Swagger::LocationSchema

  included do
    swagger_path '/api/v1/locations/postal/{postalCode}' do # エンドポイント
      operation :get do # HTTPアクション
        key :description, "郵便番号から住所の一覧を取得する" # エンドポイントの説明
        key :operationId, "GetAddressList" # オペレーションID
        key :produces, [
          'application/json',
        ]
        key :tags, [
          'location',
        ]

        parameter do
          key :name, :postalCode # 名前
          key :in, :path # パラメータのタイプ(path or query)
          key :description, "郵便番号" # パラメータの説明
          key :required, true # 必須?
          key :type, :string # パラメータの型
          key :maxLength, 7
          key :minLength, 7
        end

        response 200 do
          key :description, "該当住所一覧"
          schema do
            key :'$ref', :LocationModel1 # レスポンスの型
          end
        end

        response 404 do
          key :description, "該当住所無し"
          schema do
            key :'$ref', :LocationModel1
          end
        end

        extend Swagger::ErrorSchema::BadRequest
      end
    end
  end
end

```

### レスポンスの仕様
**ディレクトリ:** *app/models/concerns/swagger/*
レスポンスの型を定義する．  
コントローラ *LocationsApi* 内の ***LocationModel1*** がそれにあたる．
```Ruby
# app/controllers/concerns/swagger/v1/location_api.rb
response 404 do
  key :description, "該当住所無し"
  schema do
    key :'$ref', :LocationModel1
  end
end
```
```Ruby
# app/models/concerns/location_schema.rb
module Swagger::LocationSchema
  extend ActiveSupport::Concern
  extend Swagger::Blocks

  included do
    swagger_schema :LocationModel1 do # 郵便番号で検索
      key :required, [:count, :results]
      property :count do
        key :description, "該当件数"
        key :type, :integer
        key :format, :int64
      end
      property :results do
        key :description, "該当情報"
        key :type, :array
        items do
          property :location do
            key :description, "所在地名称"
            key :type, :string
          end
          property :locationCode do
            key :description, "所在地コード"
            key :type, :string
          end
        end
      end
    end
  end
end
```
各パラメータなど宣言ルールに関しては[OpenAPI2.0の仕様詳細](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md)が詳細に書かれているので参照．  
後々Apivoreというライブラリを使うことでswaggerを活かしたテスト実行が可能になる．
レスポンススキーマのrequiredにはarrayなどにネストされた値を指定することができない．

***  
\clearpage

## swagger_ui_engine
swagger-blocksで定義した仕様をwebUI上に表示してくれる便利なやつ．  
実際にここからリクエストを送ることも可能．

![swagger_ui_engine](swaggershot.png){#fig:graph height=100%}

### 導入
swagger_ui_engineはswagger-blocksなどのOpenAPI2.0で記述されたjsonファイルかyamlファイルを見て動的にwebページを生成する．

```Ruby
# config/initializers/swagger_ui_engine.rb
SwaggerUiEngine.configure do |config|
  config.swagger_url = {
    v1: '/api/v1/swagger.json',
  }

  config.doc_expansion = 'list'
  config.model_rendering = 'schema'
  config.validator_enabled = false
end

# config/routes.rb
Rails.application.routes.draw do
  mount SwaggeruiEngine::Engine, at: '/swagger'
end
```

上の**swagger_controller#indexへのpath**をv1としてSwaggerUiEngineに渡すことで/swaggerにアクセスした際swagger_contoroller#indexから生成されるjsonを参照してswagger_uiのページが生成される．

### Options
#### HTTP Basic Authorization
環境変数にUSERNAME, PASSWORDともに設定されていないと認証が行われない為注意が必要．
```Ruby
# config/initializers/swagger_ui_engine.rb
SwaggerUiEngine.configure do |config|
  config.admin_username = ENV['ADMIN_USERNAME']
  config.admin_password = ENV['ADMIN_PASSWORD']
end
```
