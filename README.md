[![Gem Version](https://badge.fury.io/rb/swagger_codegen_rails.svg)](https://badge.fury.io/rb/swagger_codegen_rails)
[![Build Status](https://travis-ci.org/technobrain/swagger_codegen_rails.svg?branch=master)](https://travis-ci.org/technobrain/swagger_codegen_rails)
[![CircleCI](https://circleci.com/gh/technobrain/swagger_codegen_rails.svg?style=svg)](https://circleci.com/gh/technobrain/swagger_codegen_rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/b80adfbb67fff2493c4e/maintainability)](https://codeclimate.com/github/technobrain/swagger_codegen_rails/maintainability)

# SwaggerCodegenRails
this plugin generate SWAGGER API document's templates for [swagger-blocks](https://github.com/fotinakis/swagger-blocks), [swagger_ui_engine](https://github.com/zuzannast/swagger_ui_engine).


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'swagger_codegen_rails'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install swagger_codegen_rails
```

## Usage
### Demo
```bash
$ rails g swagger:install
$ rails g swagger:init /api/v1
$ rails g swagger:add /api/v1 /api/v1/user/:id id:path:integer:true
```

### Create intializer file
```bash
$ rails g swagger:install
```
  
### Modify **config/intializers/swagger_codegen_rails.rb**, example below
```Ruby
# config/initializers/swagger_codegen_rails.rb

SwaggerCodegenRails.configure do |config|
  config.versions_url = {
    v1: 'api/v1',
    v2: 'api/v2'
  }

  config.concern_dir = "/path/to/your/concern/directory"
  # default: /app/controllers/concerns

  config.schema_dir = "/path/to/your/schema/dir"
  # default: /app/models/concerns
end
```

Options:  

|configurations|type|default|description|
|:------|:----|:-|:-------------------------|
config.versions_url|hash|EMPTY|define versioned path|
|config.concern_dir|string|/app/controllers/concern|set root path of endpoint documentations|
|config.schema_dir|string|/app/models/concern|set root path of response schema documentations|
  

### To Create Namespace
```bash
$ rails g swagger:init NAMESPACE
```

### To add Endpoint
```bash
$ rails g swagger:add NAMESPACE HTTP_METHOD URI [PARAMETERS; name:in:type:required]
$ # If you do NOT want namespace, example below
$ rails g swagger:add . GET /users id:path:integer:true
```
Parameters:

||description|
|:-|:-|
|name|parameter name|
|in|ex) in =\> /items?id=###, query =\> parameter is id.|
|type|data type|
|required|required|


### To show SwaggerUI
Add these lines in your config/application.rb (If you won't create versioned API, it is no needed.)
```Ruby
# config/application.rb
config.paths.add "#{config.root}/app/controllers/**/*", glob: "**/*", eager_load: true
```

Then start your server with rails command
```bash
$ rails s
```
And access ``http://localhost:3000/swagger`` in browser.



## Contributing
1. Fork it ( https://github.com/technobrain/swagger_codegen_rails )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
