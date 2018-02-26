module Swagger
  class InstallGenerator < ::Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      template "_initializer.rb.tt", "config/initializers/swagger_codegen_rails.rb" 
    end

    def create_swagger_ui_initializer_file
      template "_swagger_ui_initializer.rb.tt", "config/initializers/swagger_ui_engine.rb"
    end

    def insert_ui_route
      route "mount SwaggerUiEngine::Engine, at: '/swagger'"
    end

    private
    def initializer_exist?
      initializer_path = "config/initializers/swagger_ui_engine.rb"
      File.exist?(initializer_path)
    end
  end
end
