module SwaggerCodegenRails
  class AddGenerator < ::Rails::Generators::NamedBase
    argument :http_method, type: :string, required: true
    argument :uri, type: :string, required: true
    argument :parameter, type: :array, required: false, banner: 'name:in:type:required'

    source_root File.expand_path('../templates', __FILE__)

    def arguments
      @params = ::SwaggerCodegenRails.parse(parameter)
    end

    def create_endpoint_doc
      template '_swagger.rb.tt', File.join(swagger_path, "_#{file_name}.rb") if file_name
    end

    private
    def module_name
      file_name.camelize
    end

    def swagger_path
      base_path = SwaggerCodegenRails.configuration.concern_dir
      File.join(base_path, name)
    end

    def file_name
      name_space = File.dirname("/" + name + "/")
      if uri.start_with?(name_space)
        uri.sub(name_space, '').gsub("/", "_").gsub(":",'')
      else
        raise ArgumentError
      end
    rescue ArgumentError => e
      Rails.logger.error e
      Rails.logger.error e.backtrace.join("\n")
    end
  end
end
