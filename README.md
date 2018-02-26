[![Build Status](https://travis-ci.org/technobrain/swagger_codegen_rails.svg?branch=master)](https://travis-ci.org/technobrain/swagger_codegen_rails)
[![CircleCI](https://circleci.com/gh/technobrain/swagger_codegen_rails.svg?style=svg)](https://circleci.com/gh/technobrain/swagger_codegen_rails)

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
### Create intializer file
```bash
$ rails g swagger:install
```
  
### Modify **config/intializers/swagger_codegen_rails.rb**, example below
```Ruby
# config/initializers/swagger_codegen_rails.rb

SwaggerCodegenRails.configure do |config|
  config.versioned = false # boolean

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
|config.versioned|boolean|false|set path of versioned API documentations|
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
```

Parameters:
||description|
|:-|:-|
|name|parameter name|
|in|ex) in =\> /items?id=###, query =\> parameter is id.|
|type|data type|
|required|required|


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
