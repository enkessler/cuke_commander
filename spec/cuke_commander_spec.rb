require 'spec_helper'


describe 'CukeCommander, Unit' do

  let(:nodule) { CukeCommander }


  it 'is defined' do
    expect(Kernel.const_defined?(:CukeCommander)).to be true
  end

  it 'defines the available Cucumber options' do
    expect(nodule.const_defined?(:CUKE_OPTIONS)).to be true
  end

end
