# Example to Use
```Ruby
# config/initializers/swagger_codegen_rails.rb

SwaggerCodegenRails.configure do |config|
  config.concern_directory = "/path/to/your/concern/directory"
  config.schema_directory = "/path/to/your/schema/dir"
end
```
```bash
rails g swagger:install
```
