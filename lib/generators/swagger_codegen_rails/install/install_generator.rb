module SwaggerCodegenRails
  class InstallGenerator < ::Rails::Generators::NamedBase

    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      template "_initializer.rb.tt", "config/initializers/swagger_ui_engine.rb"
    end

    def create_concern_dir
      dir = SwaggerCodegenRails.configuration.concern_dir
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
    end

    def create_swagger_controller_file
      template "_swagger_controller.rb.tt", swagger_controller_path
    end

    private
    def swagger_controller_path
      File.expand_path(File.join("app/controllers", name, "swagger_controller.rb"))
    end
  end
end
