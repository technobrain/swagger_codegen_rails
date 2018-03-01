module SwaggerCodegenRails
  module Konstants

    include SwaggerCodegenRails::Base

    def include_swagger(path)
      find_from_path(concern_dir, "/**/*.rb").each do |path|
        include Konstant.new(path, concern_dir).specify!
      end
    end

    def find_from_path(source, match)
      Dir.glob(File.join(source, match))
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
