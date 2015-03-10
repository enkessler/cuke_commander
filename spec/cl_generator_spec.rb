require 'spec_helper'


describe 'CLGenerator, Unit' do

  clazz = CukeCommander::CLGenerator

  before(:each) { @generator = clazz.new }


  it 'is in the correct module' do
    expect(clazz.ancestors).to include(CukeCommander::CLGenerator)
  end

  it 'can generate a command line' do
    expect(@generator).to respond_to(:generate_command_line)
  end

  it 'returns a String' do
    expect(@generator.generate_command_line).to be_a String
  end

  it 'can build a command line based on arguments' do
    expect(@generator.method(:generate_command_line).arity).to eq(-1)
  end

  it 'can handle generating a command line when options are not specified' do
    expect { @generator.generate_command_line }.to_not raise_exception
  end

  it 'only accepts a Hash as a parameter' do
    options = [1, 2, 3]
    expect { @generator.generate_command_line(options) }.to raise_error(ArgumentError)
  end

  it 'only accepts cucumber options' do
    options = {:not_a_cucumber_option => ['123', '345', '678']}
    expect { @generator.generate_command_line(options) }.to raise_exception
  end

  it 'only accepts container option values' do
    options = {not_a_container: '123'}
    expect { @generator.generate_command_line(options) }.to raise_exception
  end

  it 'will not set no_source flag when value is false' do
    options = {:no_source => [false]}
    expect(@generator.generate_command_line(options)).to eq('cucumber')
  end

  it 'will not set no_color flag when value is false' do
    options = {:no_color => [false]}
    expect(@generator.generate_command_line(options)).to eq('cucumber')
  end

end
