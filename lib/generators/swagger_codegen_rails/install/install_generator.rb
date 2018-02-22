module SwaggerCodegenRails
  class InstallGenerator < ::Rails::Generators::Base
    argument :namespace, required: false
    class_option :namespace, required: false, aliases: '-n'

    def create_initializer_file
      template "_initializer.rb", "app/initializers/swagger_codegen_rails.rb" unless initializer_exist?
    end

    def create_concern_dir
      dir = Configuration.concern_dir
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
    end

    def create_swagger_controller_file
      template "_swagger_controller.rb", swagger_controller_path unless File.exist?(swagger_controller_path)
    end

    private
    def initializer_exist?
      initializer_path = File.extend_path("config/initializers/swagger_codegen_rails.rb")
      File.exist?(initializer_path)
    end

    def swagger_controller_path
      return "app/controllers/swagger_controller.rb" unless options[:namespace]
      File.join("app/controllers", options[:namespace], "swagger_controller.rb")
    end
  end
end
