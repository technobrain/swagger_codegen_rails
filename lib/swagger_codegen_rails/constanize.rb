module SwaggerCodegenRails
  module Constanize

    def constants(paths)
      byebug
      base_dir = SwaggerCodegenRails.configuration.concern_dir

      paths.map do |path|
        namespace_dir(path).map do |dir|
          dir.camelize
        end.join("::")
      end
    end

    def namespace_dir(path)
      File.dirname(path.sub(base_dir, '')).sub(/\A\//).split("/")
    end
  end
end
