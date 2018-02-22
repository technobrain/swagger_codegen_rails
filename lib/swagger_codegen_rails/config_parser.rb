module SwaggerCodegenRails
  module ConfigParser
    ::SwaggerCodegenRails::DEFAULTS.each do |default|
      configuration.send("#{default.first}")
    end
  end
end
