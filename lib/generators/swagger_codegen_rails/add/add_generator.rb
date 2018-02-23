module SwaggerCodegenRails
  class AddGenerator < ::Rails::Generators::NamedBase
    argument :endpoint, type: :array, require: true

    source_root File.expand_path('../templates', __FILE__)

    def create_endpoint_doc
      endpoint.each do |uri|
        template '_swagger.rb.tt', File.join(swagger_path, file_name_parsed(uri))
      end
    end

    private
    def swagger_path
      base_path = SwaggerCodegenRails.configuration.concern_dir
      File.join(base_path, name)
    end

    def file_name_parsed(uri)
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
