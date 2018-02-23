module SwaggerCodegenRails
  class AddGenerator < ::Rails::Generators::NamedBase
    argument :http_method, type: :string, required: true
    argument :uri, type: :string, required: true
    argument :params, type: :array, required: false, banner: 'name:in:type:required'

    source_root File.expand_path('../templates', __FILE__)

    def arguments
      @params = SwaggerCodegenRails::Parameter.new
      @params.parse_params(params)
    end

    def create_endpoint_doc
      endpoint.each do |uri|
        template '_swagger.rb.tt', File.join(swagger_path, file_name) if file_name
      end
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
      namespace = "/" + name + "/"
      if uri.start_with?(namespace)
        uri.sub(namespace, '').gsub("/", "_").gsub(":",'')
      else
        raise ArgumentError
      end
    rescue ArgumentError => e
      logger.error e
      logger.error e.backtrace.join("\n")
    end
  end
end
