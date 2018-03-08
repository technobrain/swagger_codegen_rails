module SwaggerCodegenRails
  module Base
    def concern_dir
      concerns.call
    end

    def concerns
      Proc.new { SwaggerCodegenRails.configuration.concern_dir }
    end

    def schema_dir
      schemas.call
    end

    def schemas
      Proc.new { SwaggerCodegenRails.configuration.schema_dir }
    end
  end
end
