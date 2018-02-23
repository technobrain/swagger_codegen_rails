module SwaggerCodegenRails
  class InstallGenerator < ::Rails::Generators::NamedBase

    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      template "_initializer.rb.tt", "config/initializers/swagger_ui_engine.rb" unless initializer_exist?
    end

    def create_concern_dir
      directory nil, concern_dir
    end

    def create_swagger_controller_file
      template "_swagger_controller.rb.tt", swagger_controller_path
    end

    def insert_ui_route
      route "mount SwaggerUiEngine::Engine, at: '/swagger'"
    end

    private
    def swagger_controller_path
      File.join("app/controllers", name, "swagger_controller.rb")
    end

    def concern_dir
      SwaggerCodegenRails.configuration.concern_dir
    end

    def initializer_exist?
      initializer_path = "config/initializers/swagger_ui_engine.rb"
      File.exist?(initializer_path)
    end
  end
end
