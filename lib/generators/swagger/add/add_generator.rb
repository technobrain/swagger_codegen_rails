module Swagger
  class AddGenerator < ::Rails::Generators::NamedBase
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

    def version_namespace
      config = SwaggerCodegenRails.configuration.versions_url
      config[name.to_sym] || name if config
    end

    def name_space
      SwaggerCodegenRails.configuration.versions_url[name.to_sym] || name
    end

    def swagger_path
      base_path = SwaggerCodegenRails.configuration.concern_dir
      File.join(base_path, version_namespace)
    end

    def slash_replace(str)
      str.gsub("/","_").gsub(/\A_*/, '')
    end

    def swagger_file_name
      tmp_uri = slash_replace(uri)
      name_space = slash_replace(version_namespace)

      if tmp_uri.start_with?(name_space)
        tmp_uri.sub(name_space, '').gsub(":",'').sub(/\A_*/, '')
      else
        raise ArgumentError
      end
    rescue ArgumentError => e
      Rails.logger.error e
      Rails.logger.error e.backtrace.join("\n")
    end
  end
end
