require 'rails_helper'
require 'generators/swagger/add/add_generator'
require 'support/generators'

RSpec.describe Swagger::AddGenerator, type: :generator do

  setup_generator_test

  it 'runs all tasks' do
    gen = generator %w(. GET /users)
    expect(gen).to receive :arguments
    expect(gen).to receive :create_endpoint_doc
    gen.invoke_all
  end

  describe "generated file with namespace aliase" do
    before do
      SwaggerCodegenRails.configure do |config|
        config.versions_url = {
          v1: "api/v1"
        }
      end
      
      run_generator %w(v1 GET /api/v1/users)
    end

    describe "endpoint document" do
      subject { file("config/controllers/concerns/api/v1/_users.rb") }
      it { is_expected.to exist }
    end

  end
end
