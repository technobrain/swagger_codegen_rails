require 'swagger_codegen_rails/namespace'

module Swagger
  class AddGenerator < ::Rails::Generators::NamedBase
    include SwaggerCodegenRails::Namespace

    argument :http_method, type: :string, required: true
    argument :uri, type: :string, required: true
    argument :parameter, type: :array, required: false, banner: 'name:in:type:required'

    source_root File.expand_path('../templates', __FILE__)

    def arguments
      @params = ::SwaggerCodegenRails.parse(parameter)
    end

    def create_endpoint_doc
      template '_swagger.rb.tt', File.join(swagger_path, "_#{swagger_file_name}.rb") if swagger_file_name
    end

    private
    def module_name
      swagger_file_name.camelize
    end

    def name_space
      config = SwaggerCodegenRails.configuration.versions_url
      config ? (config[name.to_sym] || name) : name
    end

    def swagger_path
      base_path = SwaggerCodegenRails.configuration.concern_dir
      File.join(base_path, name_space)
    end

    def slash_replace(str)
      str&.gsub("/","_")&.gsub(/\A_*/, '')
    end

    def swagger_file_name
      slash_replace(uri.sub(name_space, ''))
    end
  end
end
