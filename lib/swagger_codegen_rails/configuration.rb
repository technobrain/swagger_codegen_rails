module SwaggerCodegenRails
  class Configuration
    OPTIONS = %i(
      concern_dir
      schema_dir
      versioned
      versions_url
    )
  end

  attr_accesor(*OPTIONS)
end
