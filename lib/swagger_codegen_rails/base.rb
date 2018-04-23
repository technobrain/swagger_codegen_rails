module SwaggerCodegenRails
  module Base
    def concern_dir
      SwaggerCodegenRails.configuration.concern_dir
    end

    def schema_dir
      SwaggerCodegenRails.configuration.schema_dir
    end
  end
end
