module Generators
  def destination_path
    File.expand_path("../../tmp", __FILE__)
  end
  
  def set_default_destination
    destination destination_path
  end

  def setup_default_destination
    set_default_destination
    before do
      prepare_destination
      create_tmp_route_file
      create_tmp_gemfile
    end
  end

  def setup_generator_test
    setup_default_destination
  end

  def create_tmp_route_file
    route_path = File.join(destination_path, "config/routes.rb")
    content = <<-EOS
    Rails.application.routes.draw do
    end
    EOS

    FileUtils.mkdir_p(File.dirname(route_path))
    open(route_path, "w") do |file|
      file.puts content
    end
  end

  def create_tmp_gemfile
    gemfile_path = File.join(destination_path, "Gemfile")
    content = <<-EOS
    source "https://rubygems.org"

    gem "rails"
    EOS

    open(gemfile_path, "w") do |file|
      file.puts content
    end
  end

  def self.included(klass)
    klass.extend(Generators)
  end
end

RSpec.configure do |config|
  config.include Generators, :type => :generator
end
