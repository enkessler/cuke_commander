require 'spec_helper'


describe 'CLGenerator, Unit' do

  let(:clazz) { CukeCommander::CLGenerator }
  let(:generator) { clazz.new }


  it 'is defined' do
    expect(CukeCommander.const_defined?(:CLGenerator)).to be true
  end

  it 'can generate a command line' do
    expect(generator).to respond_to(:generate_command_line)
  end

  it 'returns a string that represents a Cucumber command line' do
    expect(generator.generate_command_line).to be_a String
    expect(generator.generate_command_line).to match(/^cucumber ?/)
  end

  it 'can build a command line based on options' do
    expect(generator.method(:generate_command_line).arity).to eq(-1)
  end

  describe 'option handling' do

    all_options = {profiles: 'foo',
                   tags: 'foo',
                   file_paths: 'foo',
                   formatters: {some_formatter: 'some_file.txt'},
                   exclude_files: 'foo',
                   no_source: true,
                   no_color: true,
                   options: 'foo'}

    let(:test_options) { all_options.dup }
    let(:bad_value) { 7 }

    before(:all) do
      # Not an actual test but here to make sure that the test data is
      # updated when options are added or removed
      expect(all_options.keys).to match_array(CukeCommander::CUKE_OPTIONS.collect { |option| option.to_sym })
    end

    it 'can handle generating a command line when no options are provided' do
      expect { generator.generate_command_line }.to_not raise_exception
    end

    it 'can handle generating a command line when all options are provided' do
      expect { generator.generate_command_line(all_options) }.to_not raise_exception
    end

    it 'only accepts cucumber options' do
      options = {:not_a_cucumber_option => ['123', '345', '678']}
      expect { generator.generate_command_line(options) }.to raise_exception
    end

    CukeCommander::CUKE_OPTIONS.each do |option|

      it "can handle generating a command line when the '#{option}' option is provided" do
        test_options.keep_if { |key, value| key == option }

        expect { generator.generate_command_line }.to_not raise_exception
      end

      it "can handle generating a command line when the '#{option}' option is not provided" do
        test_options.delete_if { |key, value| key == option }

        expect { generator.generate_command_line }.to_not raise_exception
      end

      it "validates the '#{option}' option" do
        test_options[option.to_sym] = bad_value

        expect { generator.generate_command_line(test_options) }.to raise_error(ArgumentError, /must.*got.*#{bad_value.class}/)
      end

    end

    it 'only accepts an options Hash as an argument' do
      options = [1, 2, 3]

      expect { generator.generate_command_line(options) }.to raise_error(ArgumentError, /must.*Hash.*got.*#{options.class}/)
    end

    it 'only accepts a string or array as a profile value' do
      expect { generator.generate_command_line({profiles: 'foo'}) }.to_not raise_error
      expect { generator.generate_command_line({profiles: ['foo', 'bar']}) }.to_not raise_error
      expect { generator.generate_command_line({profiles: bad_value}) }.to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a string or array as a tag value' do
      expect { generator.generate_command_line({tags: 'foo'}) }.to_not raise_error
      expect { generator.generate_command_line({tags: ['foo', 'bar']}) }.to_not raise_error
      expect { generator.generate_command_line({tags: bad_value}) }.to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a string or array as a file path value' do
      expect { generator.generate_command_line({file_paths: 'foo'}) }.to_not raise_error
      expect { generator.generate_command_line({file_paths: ['foo', 'bar']}) }.to_not raise_error
      expect { generator.generate_command_line({file_paths: bad_value}) }.to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a hash as a formatters value' do
      expect { generator.generate_command_line({formatters: {}}) }.to_not raise_error
      expect { generator.generate_command_line({formatters: bad_value}) }.to raise_error(ArgumentError, /must.*Hash.*got.*#{bad_value.class}/)
    end

    it 'only accepts a string or array as an excluded file value' do
      expect { generator.generate_command_line({exclude_files: 'foo'}) }.to_not raise_error
      expect { generator.generate_command_line({exclude_files: ['foo', 'bar']}) }.to_not raise_error
      expect { generator.generate_command_line({exclude_files: bad_value}) }.to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a no-source value' do
      expect { generator.generate_command_line({no_source: true}) }.to_not raise_error
      expect { generator.generate_command_line({no_source: false}) }.to_not raise_error
      expect { generator.generate_command_line({no_source: bad_value}) }.to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a no-color value' do
      expect { generator.generate_command_line({no_color: true}) }.to_not raise_error
      expect { generator.generate_command_line({no_color: false}) }.to_not raise_error
      expect { generator.generate_command_line({no_color: bad_value}) }.to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a string or array as an options value' do
      expect { generator.generate_command_line({options: 'foo'}) }.to_not raise_error
      expect { generator.generate_command_line({options: ['foo', 'bar']}) }.to_not raise_error
      expect { generator.generate_command_line({options: bad_value}) }.to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end
  end

  describe 'old bugs' do
    # Was doing an existence check instead of a true/false check
    it 'will not set no_source flag when value is false' do
      options = {no_source: false}
      expect(generator.generate_command_line(options)).to eq('cucumber')
    end

    # Was doing an existence check instead of a true/false check
    it 'will not set no_color flag when value is false' do
      options = {no_color: false}
      expect(generator.generate_command_line(options)).to eq('cucumber')
    end
  end

end
