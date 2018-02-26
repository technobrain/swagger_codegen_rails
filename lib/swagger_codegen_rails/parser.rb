module SwaggerCodegenRails::Parser
  def parse(param_strings)
    param_strings&.map do |str|
      params = SwaggerCodegenRails::Parameter.new
      params.map_params(str)
    end
  end
end
