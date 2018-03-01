require 'rails_helper'

describe SwaggerCodegenRails::Base do
  let(:klass) { Struct.new(:base) { include SwaggerCodegenRails::Base } }
  subject { klass.new }

  context "variable set" do
    before do
      SwaggerCodegenRails.configure do |config|
        config.concern_dir = "hogehoge"
        config.schema_dir = "foobar"
      end
    end
    it "should be valid" do
      expect(subject.concern_dir).to eq("hogehoge")
      expect(subject.schema_dir).to eq("foobar")
    end
  end

  context "default variable" do
    before do
      SwaggerCodegenRails.configure do |config|
      end
    end

    it "should be valid" do
      expect(subject.concern_dir).to eq("app/controllers/concerns")
      expect(subject.schema_dir).to eq("app/models/concerns")
    end
  end
end
