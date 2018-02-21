require 'swagger_codegen_rails/version'
require 'swagger_codegen_rails/configuration'

module SwaggerCodegenRails
  extend self

  delegate(*Configuration::OPTIONS, to: :configuration)

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield configuration
  end
end
