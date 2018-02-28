module SwaggerCodegenRails
  class Namespace < ActionView::Base
    #include ActionView::Helpers
    # include ActionView::Context

    attr_reader :name

    # @name = ["api", "v1"]
    def initialize(name = nil)
      @name = namespaces(name) if name
    end

    def module_namespacing(&block)
      return unless namespaced?
      content = capture(&block)
      @name&.each do |name|
        content = wrap_with_namespace(content, name)
      end
      #concat(content)
      content
    end

    def namespaces(name)
      name.gsub('.','').split("/").reject(&:blank?).map(&:camelize)
    end

    def namespaced?
      @name
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
