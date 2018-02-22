module SwaggerCodegenRails
  class Configuration
    OPTIONS = %i(
      concern_dir
      schema_dir
      versioned
      versions_url
    )

    attr_accessor(*OPTIONS)
  end
end
