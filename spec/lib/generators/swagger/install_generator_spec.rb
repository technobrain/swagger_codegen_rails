require 'rails_helper'
require 'generators/swagger/install/install_generator'
require 'support/generators'

RSpec.describe Swagger::InstallGenerator, type: :generator do

  setup_generator_test

  it 'runs all tasks' do
    gen = generator
    expect(gen).to receive :create_initializer_file
    expect(gen).to receive :create_swagger_ui_initializer_file
    expect(gen).to receive :insert_ui_route
    gen.invoke_all
  end

  describe "generated files" do
    before do
      run_generator %w(.)
    end

    describe "swagger_ui_engine initializer file" do
      subject { file("config/initializers/swagger_ui_engine.rb") }
      it { is_expected.to exist }
      it { is_expected.to contain(/SwaggerUiEngine.configure do |config|/) }
    end

    describe "initializer file" do
      subject { file("config/initializers/swagger_codegen_rails.rb") }
      it { is_expected.to exist }
    end

    describe "route file" do
      subject { file("config/routes.rb") }
      it { is_expected.to contain(/mount SwaggerUiEngine::Engine, at:/) }
    end
  end
end
