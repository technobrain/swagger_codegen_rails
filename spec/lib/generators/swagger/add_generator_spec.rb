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
      
      run_generator %w(v1 GET /users id:query:integer:true)
    end

    describe "endpoint document" do
      subject { file("app/controllers/concerns/api/v1/users.rb") }
      it { is_expected.to exist }
      it { is_expected.to contain("module Api") }
      it { is_expected.to contain("module V1") }
      it { is_expected.to contain("swagger_path '/api/v1/users' do") }
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
      subject { file("app/controllers/concerns/api/v1/users.rb") }
      it { is_expected.to exist }
      it { is_expected.to contain("module Api") }
      it { is_expected.to contain("module V1") }
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
      subject { file("app/controllers/concerns/api/v1/users.rb") }
      it { is_expected.to exist }
      it { is_expected.to contain("module User") }
      it { is_expected.not_to contain("parameter do") }
    end
  end

  describe "generated files without namespace" do
    before do
      run_generator %w(. POST /users id:path:integer:true)
    end

    describe "endpoint document" do
      subject { file("app/controllers/concerns/users.rb") }
      it { is_expected.to exist }
      it { is_expected.to contain("key :name, :id") }
      it { is_expected.to contain("key :in, :path") }
      it { is_expected.to contain("key :type, :integer") }
      it { is_expected.to contain("key :required, true") }
    end
  end

  describe "gerated files without strange params format" do
    subject { file("app/controllers/concerns/users.rb") }

    describe "only name" do
      before do
        run_generator %w(. GET /users id:::)
      end
      it { is_expected.to exist }
      it { is_expected.to contain("key :name, :id") }
      it { is_expected.to contain("key :in, :TODO") }
      it { is_expected.to contain("key :type, :TODO") }
      it { is_expected.to contain("key :required, TODO") }
    end
  end
end
