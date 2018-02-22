require 'rails_helper'
require 'generators/swagger_codegen_rails/install/install_generator'

describe SwaggerCodegenRails::InstallGenerator, type: :generator do

  destination File.expand_path("../../../tmp", __FILE__)
  before do
    prepare_destination
  end

  it 'runs all tasks' do
    gen = generator %w(api)
    expect(gen).to receive :create_initializer_file
    expect(gen).to receive :create_concern_dir
    expect(gen).to receive :create_swagger_controller_file
    expect(gen).to receive :insert_ui_route
    gen.invoke_all
  end
end
