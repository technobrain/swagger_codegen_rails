require'rails/generators/named_base'

module SwaggerCodegenRails
  class InstallGenerator < ::Rails::Generators::Base
    argument :namespace, required: false

    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      template "_initializer.rb", "config/initializers/swagger_ui_engine.rb" unless initializer_exist?
    end

    def create_concern_dir
      dir = SwaggerCodegenRails.configuration.concern_dir
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
    end

    def create_swagger_controller_file
      template "_swagger_controller.rb", swagger_controller_path unless File.exist?(swagger_controller_path)
    end

    private
    def initializer_exist?
      initializer_path = File.expand_path("config/initializers/swagger_ui_engine.rb")
      File.exist?(initializer_path)
    end

    def swagger_controller_path
      return "app/controllers/swagger_controller.rb" unless options[:namespace]
      File.join("app/controllers", options[:namespace], "swagger_controller.rb")
    end
  end
end
