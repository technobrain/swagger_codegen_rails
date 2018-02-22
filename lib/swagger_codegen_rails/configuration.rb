module SwaggerCodegenRails
  class Configuration
    OPTIONS = %i(
      concern_dir
      schema_dir
      versioned
      versions_url
    ).freeze

    attr_accessor(*OPTIONS)

    def initialize
      DEFAULTS.each do |default|
        self.class.send(:define_method, default.first) { default.last }
      end
    end
  end
end
