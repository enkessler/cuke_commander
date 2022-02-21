require_relative '../../../environments/rspec_env'


RSpec.describe 'CLGenerator, Unit' do

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

    all_options = { profiles:   'foo',
                    tags:       'foo',
                    file_paths: 'foo',
                    formatters: { some_formatter: 'some_file.txt' },
                    excludes:   'foo',
                    no_source:  true,
                    no_color:   true,
                    options:    'foo',
                    backtrace:  true,
                    color:      true,
                    dry_run:    true,
                    expand:     true,
                    guess:      true,
                    help:       true,
                    names:      'foo',
                    no_profile: true,
                    quiet:      true,
                    requires:   'foo',
                    strict:     true,
                    verbose:    true,
                    version:    true,
                    wip:        true,
                    long_flags: false }

    let(:test_options) { all_options.dup }
    let(:bad_value) { 7 }

    before(:all) do
      # Not an actual test but here to make sure that the test data is
      # updated when options are added or removed
      expect(all_options.keys).to match_array(CukeCommander::CUKE_OPTIONS.map(&:to_sym))
    end

    it 'can handle generating a command line when no options are provided' do
      expect { generator.generate_command_line }.to_not raise_exception
    end

    it 'can handle generating a command line when all options are provided' do
      expect { generator.generate_command_line(all_options) }.to_not raise_exception
    end

    it 'only accepts cucumber options' do
      options = { not_a_cucumber_option: %w[123 345 678] }
      expect { generator.generate_command_line(options) }.to raise_exception
    end

    CukeCommander::CUKE_OPTIONS.each do |option|

      it "can handle generating a command line when the '#{option}' option is provided" do
        test_options.keep_if { |key, _value| key == option }

        expect { generator.generate_command_line }.to_not raise_exception
      end

      it "can handle generating a command line when the '#{option}' option is not provided" do
        test_options.delete_if { |key, _value| key == option }

        expect { generator.generate_command_line }.to_not raise_exception
      end

      it "validates the '#{option}' option" do
        test_options[option.to_sym] = bad_value

        expect { generator.generate_command_line(test_options) }
          .to raise_error(ArgumentError, /must.*got.*#{bad_value.class}/)
      end

    end

    it 'only accepts an options Hash as an argument' do
      options = [1, 2, 3]

      expect { generator.generate_command_line(options) }
        .to raise_error(ArgumentError, /must.*Hash.*got.*#{options.class}/)
    end

    it 'only accepts a string or array as a profile value' do
      expect { generator.generate_command_line(profiles: 'foo') }.to_not raise_error
      expect { generator.generate_command_line(profiles: %w[foo bar]) }.to_not raise_error
      expect { generator.generate_command_line(profiles: bad_value) }
        .to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a string or array as a tag value' do
      expect { generator.generate_command_line(tags: 'foo') }.to_not raise_error
      expect { generator.generate_command_line(tags: %w[foo bar]) }.to_not raise_error
      expect { generator.generate_command_line(tags: bad_value) }
        .to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a string or array as a file path value' do
      expect { generator.generate_command_line(file_paths: 'foo') }.to_not raise_error
      expect { generator.generate_command_line(file_paths: %w[foo bar]) }.to_not raise_error
      expect { generator.generate_command_line(file_paths: bad_value) }
        .to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a hash as a formatters value' do
      expect { generator.generate_command_line(formatters: {}) }.to_not raise_error
      expect { generator.generate_command_line(formatters: bad_value) }
        .to raise_error(ArgumentError, /must.*Hash.*got.*#{bad_value.class}/)
    end

    it 'only accepts a string or array as an excluded patterns value' do
      expect { generator.generate_command_line(excludes: 'foo') }.to_not raise_error
      expect { generator.generate_command_line(excludes: %w[foo bar]) }.to_not raise_error
      expect { generator.generate_command_line(excludes: bad_value) }
        .to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a no-source value' do
      expect { generator.generate_command_line(no_source: true) }.to_not raise_error
      expect { generator.generate_command_line(no_source: false) }.to_not raise_error
      expect { generator.generate_command_line(no_source: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a no-color value' do
      expect { generator.generate_command_line(no_color: true) }.to_not raise_error
      expect { generator.generate_command_line(no_color: false) }.to_not raise_error
      expect { generator.generate_command_line(no_color: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a color value' do
      expect { generator.generate_command_line(color: true) }.to_not raise_error
      expect { generator.generate_command_line(color: false) }.to_not raise_error
      expect { generator.generate_command_line(color: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a backtrace value' do
      expect { generator.generate_command_line(backtrace: true) }.to_not raise_error
      expect { generator.generate_command_line(backtrace: false) }.to_not raise_error
      expect { generator.generate_command_line(backtrace: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a dry run value' do
      expect { generator.generate_command_line(dry_run: true) }.to_not raise_error
      expect { generator.generate_command_line(dry_run: false) }.to_not raise_error
      expect { generator.generate_command_line(dry_run: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as an expand value' do
      expect { generator.generate_command_line(expand: true) }.to_not raise_error
      expect { generator.generate_command_line(expand: false) }.to_not raise_error
      expect { generator.generate_command_line(expand: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a guess value' do
      expect { generator.generate_command_line(guess: true) }.to_not raise_error
      expect { generator.generate_command_line(guess: false) }.to_not raise_error
      expect { generator.generate_command_line(guess: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a help value' do
      expect { generator.generate_command_line(help: true) }.to_not raise_error
      expect { generator.generate_command_line(help: false) }.to_not raise_error
      expect { generator.generate_command_line(help: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a quiet value' do
      expect { generator.generate_command_line(quiet: true) }.to_not raise_error
      expect { generator.generate_command_line(quiet: false) }.to_not raise_error
      expect { generator.generate_command_line(quiet: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a strict value' do
      expect { generator.generate_command_line(strict: true) }.to_not raise_error
      expect { generator.generate_command_line(strict: false) }.to_not raise_error
      expect { generator.generate_command_line(strict: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a verbose value' do
      expect { generator.generate_command_line(verbose: true) }.to_not raise_error
      expect { generator.generate_command_line(verbose: false) }.to_not raise_error
      expect { generator.generate_command_line(verbose: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a version value' do
      expect { generator.generate_command_line(version: true) }.to_not raise_error
      expect { generator.generate_command_line(version: false) }.to_not raise_error
      expect { generator.generate_command_line(version: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a wip value' do
      expect { generator.generate_command_line(wip: true) }.to_not raise_error
      expect { generator.generate_command_line(wip: false) }.to_not raise_error
      expect { generator.generate_command_line(wip: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a no profile value' do
      expect { generator.generate_command_line(no_profile: true) }.to_not raise_error
      expect { generator.generate_command_line(no_profile: false) }.to_not raise_error
      expect { generator.generate_command_line(no_profile: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

    it 'only accepts a string or array as a require value' do
      expect { generator.generate_command_line(requires: 'foo') }.to_not raise_error
      expect { generator.generate_command_line(requires: %w[foo bar]) }.to_not raise_error
      expect { generator.generate_command_line(requires: bad_value) }
        .to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a string or array as a name value' do
      expect { generator.generate_command_line(names: 'foo') }.to_not raise_error
      expect { generator.generate_command_line(names: %w[foo bar]) }.to_not raise_error
      expect { generator.generate_command_line(names: bad_value) }
        .to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a string or array as an options value' do
      expect { generator.generate_command_line(options: 'foo') }.to_not raise_error
      expect { generator.generate_command_line(options: %w[foo bar]) }.to_not raise_error
      expect { generator.generate_command_line(options: bad_value) }
        .to raise_error(ArgumentError, /must.*String or Array.*got.*#{bad_value.class}/)
    end

    it 'only accepts a boolean as a long flag value' do
      expect { generator.generate_command_line(long_flags: true) }.to_not raise_error
      expect { generator.generate_command_line(long_flags: false) }.to_not raise_error
      expect { generator.generate_command_line(long_flags: bad_value) }
        .to raise_error(ArgumentError, /must.*true or false.*got.*#{bad_value.class}/)
    end

  end

  describe 'old bugs' do
    # Was doing an existence check instead of a true/false check
    it 'will not set no_source flag when value is false' do
      options = { no_source: false }
      expect(generator.generate_command_line(options)).to eq('cucumber')
    end

    # Was doing an existence check instead of a true/false check
    it 'will not set no_color flag when value is false' do
      options = { no_color: false }
      expect(generator.generate_command_line(options)).to eq('cucumber')
    end
  end

end
