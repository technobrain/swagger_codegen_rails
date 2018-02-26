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

  describe "generated file with namespace alias" do
    before do
      SwaggerCodegenRails.configure do |config|
        config.versions_url = {
          v1: "api/v1"
        }
      end
      
      run_generator %w(v1 GET /api/v1/users id:query:integer:true)
    end

    describe "endpoint document" do
      subject { file("app/controllers/concerns/api/v1/_users.rb") }
      it { is_expected.to exist }
      it { is_expected.to contain("module User") }
      it { is_expected.to contain("key :name, :id") }
      it { is_expected.to contain("key :in, :query") }
      it { is_expected.to contain("key :type, :integer") }
      it { is_expected.to contain("key :required, true") }
    end
  end

  describe "generated file with raw namespace" do
    before do
      run_generator %w(api/v1 GET /api/v1/users id:query:integer:true)
    end

    describe "endpoint document" do
      subject { file("app/controllers/concerns/api/v1/_users.rb") }
      it { is_expected.to exist }
      it { is_expected.to contain("module User") }
      it { is_expected.to contain("key :name, :id") }
      it { is_expected.to contain("key :in, :query") }
      it { is_expected.to contain("key :type, :integer") }
      it { is_expected.to contain("key :required, true") }
    end
  end

  describe "generated file without params" do
    before do
      run_generator %w(api/v1 GET /api/v1/users)
    end

    describe "endopoint document" do
      subject { file("app/controllers/concerns/api/v1/_users.rb") }
      it { is_expected.to exist }
      it { is_expected.to contain("module User") }
      it { is_expected.not_to contain("parameter do") }
    end
  end
end
