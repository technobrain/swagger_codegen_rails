module SwaggerCodegenRails
  class Configuration
    OPTIONS = %i(
      concern_dir
      schema_dir
      versions_url
    ).freeze

    attr_accessor(*OPTIONS)

    def initialize
      DEFAULTS.each do |default|
        self.class.send(:define_method, default.first) { default.last }
      end
    end

    def swagger_url
      self.versions_url.map { |k, v| [k, File.join("/", v, "swagger.json")] }.to_h
    end
  end
end
