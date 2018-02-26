
require 'rails_helper'
require 'generators/swagger/init/init_generator'
require 'support/generators'

RSpec.describe Swagger::InitGenerator, type: :generator do

  setup_generator_test

  it 'run_all_tasks' do
    gen = generator %w(api/v1)
    expect(gen).to receive :create_concern_dir
    expect(gen).to receive :create_namespace_dir
    expect(gen).to receive :create_swagger_controller_file
    gen.invoke_all
  end

  describe "generated files" do
    before do
      run_generator %w(api/v1)
    end

    describe "concern_dir" do
      subject { file("app/controllers/concerns") }
      it { is_expected.to exist }
    end

    describe "namespace_dir" do
      subject { file("app/controllers/concerns/api/v1") }
      it { is_expected.to exist }
    end
    
    describe "swagger_controller" do
      subject { file("app/controllers/api/v1/swagger_controller.rb") }
      it {is_expected.to exist }
    end
  end
end
