require 'swagger_codegen_rails/version'
require 'swagger_codegen_rails/configuration'
require 'swagger_codegen_rails/defaults'
require 'swagger_codegen_rails/parameter'
require 'swagger_codegen_rails/parser'

require 'generators/swagger'

SwaggerCodegenRails.extend(SwaggerCodegenRails::Parser)

module SwaggerCodegenRails
  class << self
    delegate(*Configuration::OPTIONS, to: :configuration)
  
    def configuration
      @configuration ||= Configuration.new
    end
  
    def configure
      yield(configuration)
    end
  end
end
