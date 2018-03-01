require 'rails_helper'
require 'swagger_codegen_rails/namespace'

RSpec.describe SwaggerCodegenRails::Namespace do
  let(:klass) do
    Struct.new(:namespace) do
      include SwaggerCodegenRails::Namespace
      #namespace = namespace
      def initialize(namespace)
        @namespace = namespace
        super
      end
    end
  end
  subject { klass.new(namespace) }

  describe "#split_namespace" do
    describe "name = " do
      context "." do
        let(:namespace) { "." }
        it { expect(subject.split_namespace).to eq([]) }
      end

      context "foo" do
        let(:namespace) { "foo" }
        it { expect(subject.split_namespace).to eq(["Foo"]) }
      end

      context "foo/bar" do
        let(:namespace) { "foo/bar" }
        it { expect(subject.split_namespace).to eq(["Foo", "Bar"]) }
      end

      context "/foo/bar/" do
        let(:namespace) { "/foo/bar/" }
        it { expect(subject.split_namespace).to eq(["Foo", "Bar"]) }
      end
    end
  end

end
