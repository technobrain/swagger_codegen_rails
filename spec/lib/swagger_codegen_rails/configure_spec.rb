require 'rails_helper'

RSpec.describe SwaggerCodegenRails::Configuration do
  describe "#swagger_url" do
    before do
      SwaggerCodegenRails.configure do |config|
        config.versions_url = {
          v1: "api/v1",
          v2: "/api/v2/"
        }
      end
    end

    subject { SwaggerCodegenRails.configuration.swagger_url }
    it "should be valid" do
      expect(subject[:v1]).to eq("/api/v1/swagger.json")
      expect(subject[:v2]).to eq("/api/v2/swagger.json")
    end
  end
end
