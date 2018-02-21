# Example to Use
## Directory Construction In Use
```rst
.
├── app  
│   ├── models  
│   │   └── concerns  
|   |       └── **SCHEMA_FILES**  
│   └── controllers
        ├── **swagger_controller.rb**
│       └── concerns
|           └── **CONTROLLER_NAME**  
|                 └── **ENDPOINT.rb**  
├── config
│   └── initializers  
│       └── **swagger_codegen_rails.rb**
└── spec
```

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
|configurations|type|default|description|
|:------|:----|:-|:-------------------------|
|config.versioned|boolean|false|set path of versioned API documentations|
config.versions_url|hash|EMPTY|define versioned path|
|config.concern_dir|string|/app/controllers/concern|set root path of endpoint documentations|
|config.schema_dir|string|/app/models/concern|set root path of response schema documentations


## install
**``rails g swagger_codegen_rails:install``** will create these files listed below.

- config/initializers/swagger_codegen_rails.rb
- app/controllers/swagger_controller.rb
- app/controllers/concerns

## create endpoint
**``rails g swagger_codegen_rails:add ENDPOINT CONTROLLER PARAMETERS``**
 will create
 **``app/controllers/concern/CONTROLLER/ENDPOINT.rb``**
