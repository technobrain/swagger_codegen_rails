module Generators
  def destination_path
    File.expand_path("../../tmp", __FILE__)
  end
  
  def set_default_destination
    destination destination_path
  end

  def setup_default_destination
    set_default_destination
    before { prepare_destination }
  end

  def self.included(klass)
    klass.extend(Generators)
  end
end

RSpec.configure do |config|
  config.include Generators, :type => :generator
end
