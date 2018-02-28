require 'swagger_codegen_rails/namespace'

module Swagger
  class InitGenerator < ::Rails::Generators::NamedBase
    
    include SwaggerCodegenRails::Namespace
    source_root File.expand_path('../templates', __FILE__)

    def create_concern_dir
      empty_directory concern_dir
    end

    def create_namespace_dir
      empty_directory namespace_dir
    end

    def create_swagger_controller_file
      template "_swagger_controller.rb.tt", swagger_controller_path
    end

    def insert_route
      route namespaced_route
    end

    private
    def swagger_controller_path
      File.join("app/controllers", name, "swagger_controller.rb")
    end

    def concern_dir
      SwaggerCodegenRails.configuration.concern_dir
    end

    def namespace_dir
      File.join(concern_dir, name)
    end

    def ns
      name
    end
  end
end
