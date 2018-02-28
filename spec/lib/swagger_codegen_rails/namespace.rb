require 'rails_helper'
require 'swagger_codegen_rails/namespace'

RSpec.describe SwaggerCodegenRails::Namespace do
  
  describe "#initialize" do
    subject { SwaggerCodegenRails::Namespace.new(name) }
    
    context "/api/v1" do
      let(:name) { "/api/v1" }
      it "should be valid" do
        expect(subject.namespaced?).not_to be nil
        expect(subject.name).to eq(["Api", "V1"])
      end
    end
    
    context "api/v1" do
      let(:name) { "api/v1" }
      it "should be valid" do
        expect(subject.namespaced?).not_to be nil
        expect(subject.name).to eq(["Api", "V1"])
      end
    end
    
    context "api/v1/" do
      let(:name) { "api/v1" }
      it "should be valid" do
        expect(subject.namespaced?).not_to be nil
        expect(subject.name).to eq(["Api", "V1"])
      end
    end
    
    context "." do
      let(:name) { "." }
      it "should be valid" do
        expect(subject.namespaced?).not_to be nil
        expect(subject.name).to eq([])
      end
    end
  end

  describe "#module_namespacing" do
    subject do
      namespace = SwaggerCodegenRails::Namespace.new(name)

      namespace.module_namespacing do
        <<~EOF
        class Hoge
          def initialize; end
        end
        EOF
      end
    end

    context "name = 'api/v1'" do
      let(:name) { "api/v1" }
      it "should be valid" do
        expect(subject).to include("module Api\n")
        expect(subject).to include("module V1\n")
      end
    end

    context "name = '.'" do
      let(:name) { "." }
      it "should be valid" do
        expect(subject).not_to include("module .\n")
      end
    end
  end
end
