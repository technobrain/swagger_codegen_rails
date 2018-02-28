require 'swagger_codegen_rails/namespace'

module Swagger
  class InitGenerator < ::Rails::Generators::NamedBase

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

    def module_namespacing(&block)
      return unless namespaced?
      content = capture(&block)
      namespaces.reverse.each do |name|
        content = wrap_with_namespace(content, name)
      end
      concat(content)
    end
   
    def namespaces
      name.gsub('.','').split("/").reject(&:blank?).map(&:camelize)
    end

    def namespaced?
      namespaces
    end

    def wrap_with_namespace(content, namespace)
      content = indent(content).chomp
      "module #{namespace}\n#{content}\nend\n"
    end

    def indent(content, multiplier = 2)
      spaces = " " * multiplier
      content.each_line.map { |line| line.blank? ? line : "#{spaces}#{line}" }.join
    end
  end
end
