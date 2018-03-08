module SwaggerCodegenRails
  module Konstants

    include SwaggerCodegenRails::Base

    def include_swagger(dir, type: :controller)
      find_from_path(dir, "/**/*.rb").each do |path|
        include Konstant.new(path, base_path(type)).specify!
      end
    end

    def find_from_path(source, match)
      Dir.glob(File.join(source, match))
    end

    def base_path(type)
      case type
        when :controller
          concern_dir
        when :model
          schema_dir
        else
          raise ArgumentError
      end
    rescue ArgumentError => e
      puts "ArgumentError (not in [:controller, :model])"
    end

    class Konstant
      def initialize(path, base_dir)
        @path = path
        @base_dir = base_dir
      end

      # ------------
      # app/controllers/concerns/hoge/foo/bar.rb
      # => Hoge::Foo::Bar
      # ------------
      def specify!
        constant(reduct(@path, @base_dir))
      end

      # ------------
      # app/controllers/concerns/hoge/foo/bar.rb
      # => hoge/foo/bar
      # ------------
      def reduct(source, reduction)
        File.join(File.dirname(source.sub(reduction, '')), File.basename(source, File.extname(source))).sub(/\A\//,'')
  
      end

      # ------------
      # hoge/foo/bar
      # => Hoge::Foo::Bar
      # ------------
      def constant(str)
        str.split("/").map(&:camelize).join("::").constantize
      end
  
    end
  end
end
