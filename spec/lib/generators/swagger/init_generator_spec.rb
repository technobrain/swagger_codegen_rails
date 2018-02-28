
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
    context "with namespace" do
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
        it { is_expected.to exist }
        it { is_expected.to contain("module Api") }
        it { is_expected.to contain("module V1") }
        it { is_expected.to contain("module Api\n  module V1\n") }
      end

      describe "swagger_controller" do
        subject { file("config/routes.rb") }
        it { is_expected.to exist }
        it { is_expected.to contain("namespace :api do\n") }
        it { is_expected.to contain("namespace :v1 do\n") }
        it { is_expected.to contain("resources :swagger") }
      end
    end

    context "without namespace" do
      before do
        run_generator %w(.)
      end
  
      describe "concern_dir" do
        subject { file("app/controllers/concerns") }
        it { is_expected.to exist }
      end
  
      describe "namespace_dir" do
        subject { file("app/controllers/concerns") }
        it { is_expected.to exist }
      end
      
      describe "swagger_controller" do
        subject { file("app/controllers/swagger_controller.rb") }
        it { is_expected.to exist }
        it { is_expected.not_to contain("module") }
      end
    end
  end
end
