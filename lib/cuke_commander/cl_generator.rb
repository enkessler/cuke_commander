module CukeCommander

  # The object responsible for generating Cucumber command lines.
  class CLGenerator
    # Generates a Cucumber command line.
    #
    # Most option values are either an Array or a boolean value. In the case of the former, a
    # String can be used instead of an Array when only a single value is needed. Some option
    # values come in pairs (e.g. formatters and their output locations). These option values
    # are taken as a Hash where a key is the first part of the pair and the key's value is the
    # second part.
    #
    # @param options [Hash] the Cucumber options that the command line should include.
    def generate_command_line(options = {})
      validate_options(options)
      command_line = 'cucumber'

      [:profiles, :names, :tags, :excludes, :requires].each do |option|
        append_options(command_line, wrap_options(options[option]), flag_for(option, options[:long_flags])) if options[option]
      end
      append_options(command_line, wrap_options(options[:file_paths])) if options[:file_paths]
      append_option(command_line, flag_for(:no_source, options[:long_flags]))  if options[:no_source]

      if options[:formatters]
        options[:formatters].each do |format, output_location|
          append_option(command_line, format, flag_for(:format, options[:long_flags]))
          append_option(command_line, output_location,flag_for(:output, options[:long_flags])) unless output_location.to_s.empty?
        end
      end

      [:no_color, :color, :backtrace, :dry_run, :no_profile, :guess, :wip, :quiet, :verbose, :version, :help, :expand, :strict].each do |option|
        append_option(command_line, flag_for(option,options[:long_flags])) if options[option]
      end

      append_options(command_line, wrap_options(options[:options]))                                              if options[:options]

      command_line
    end


    private


    def validate_options(options)
      raise(ArgumentError, "Argument must be a Hash, got: #{options.class}") unless options.is_a?(Hash)

      options.each_key do |option|
        raise(ArgumentError, "Option: #{option}, is not a cucumber option") unless CUKE_OPTIONS.include?(option.to_s)
      end

      raise_invalid_error('Profiles', 'a String or Array', options[:profiles])           unless valid_profiles?(options[:profiles])
      raise_invalid_error('Tags', 'a String or Array', options[:tags])                   unless valid_tags?(options[:tags])
      raise_invalid_error('File path', 'a String or Array', options[:file_paths])        unless valid_file_paths?(options[:file_paths])
      raise_invalid_error('Formatters', 'a Hash', options[:formatters])                  unless valid_formatters?(options[:formatters])
      raise_invalid_error('Excludes', 'a String or Array', options[:excludes])           unless valid_excludes?(options[:excludes])
      raise_invalid_error('No-source', 'true or false', options[:no_source])             unless valid_no_source?(options[:no_source])
      raise_invalid_error('No-color', 'true or false', options[:no_color])               unless valid_no_color?(options[:no_color])
      raise_invalid_error('Color', 'true or false', options[:color])                     unless valid_color?(options[:color])
      raise_invalid_error('Backtrace', 'true or false', options[:backtrace])             unless valid_backtrace?(options[:backtrace])
      raise_invalid_error('Expand', 'true or false', options[:expand])                   unless valid_expand?(options[:expand])
      raise_invalid_error('Guess', 'true or false', options[:guess])                     unless valid_guess?(options[:guess])
      raise_invalid_error('Help', 'true or false', options[:help])                       unless valid_help?(options[:help])
      raise_invalid_error('Dry run', 'true or false', options[:dry_run])                 unless valid_dry_run?(options[:dry_run])
      raise_invalid_error('No profile', 'true or false', options[:no_profile])           unless valid_no_profile?(options[:no_profile])
      raise_invalid_error('Quiet', 'true or false', options[:quiet])                     unless valid_quiet?(options[:quiet])
      raise_invalid_error('Strict', 'true or false', options[:strict])                   unless valid_strict?(options[:strict])
      raise_invalid_error('Verbose', 'true or false', options[:verbose])                 unless valid_verbose?(options[:verbose])
      raise_invalid_error('Version', 'true or false', options[:version])                 unless valid_version?(options[:version])
      raise_invalid_error('Wip', 'true or false', options[:wip])                         unless valid_wip?(options[:wip])
      raise_invalid_error('Names', 'a String or Array', options[:names])                 unless valid_names?(options[:names])
      raise_invalid_error('Requires', 'a String or Array', options[:requires])           unless valid_requires?(options[:requires])
      raise_invalid_error('Options', 'a String or Array', options[:options])             unless valid_options?(options[:options])
      raise_invalid_error('Long Flags', 'true or false', options[:long_flags])           unless valid_long_flags?(options[:long_flags])
    end

    def append_options(command, option_set, flag= nil)
      option_set.each do |option|
        append_option(command, option, flag)
      end
    end

    def append_option(command, option, flag= nil)
      command << " #{flag}" if flag
      command << " #{option}"
    end

    def wrap_options(option_set)
      option_set.is_a?(Array) ? option_set : [option_set]
    end

    def raise_invalid_error(option, valid_types, value_used)
      raise(ArgumentError, "#{option} option must be #{valid_types}, got: #{value_used.class}")
    end

    %w(profiles tags file_paths excludes names requires options).each do |option|
      define_method("valid_#{option}?") { |check_this| valid_string_array_value?(check_this) }
    end

    %w(no_source no_color color backtrace wip no_profile expand
       strict verbose version quiet guess help dry_run long_flags).each do |option|
      define_method("valid_#{option}?") { |check_this| valid_boolean_value?(check_this) }
    end

    def valid_formatters?(formatters)
      valid_hash_value?(formatters)
    end

    def valid_string_array_value?(value)
      value.nil? || value.is_a?(Array) || value.is_a?(String)
    end

    def valid_boolean_value?(value)
      value.nil? || (value == true) || (value == false)
    end

    def valid_hash_value?(value)
      value.nil? || value.is_a?(Hash)
    end

    def flag_for(option, long_flags)
      case option
        when :tags
          long_flags ? '--tags' : '-t'
        when :profiles
          long_flags ? '--profile' : '-p'
        when :names
          long_flags ? '--name' : '-n'
        when :excludes
          long_flags ? '--exclude' : '-e'
        when :requires
          long_flags ? '--require' : '-r'
        when :backtrace
          long_flags ? '--backtrace' : '-b'
        when :color
          long_flags ? '--color' : '-c'
        when :no_color
          '--no-color'
        when :dry_run
          long_flags ? '--dry-run' : '-d'
        when :guess
          long_flags ? '--guess' : '-g'
        when :wip
          long_flags ? '--wip' : '-w'
        when :quiet
          long_flags ? '--quiet' : '-q'
        when :help
          long_flags ? '--help' : '-h'
        when :verbose
          long_flags ? '--verbose' : '-v'
        when :version
          '--version'
        when :strict
          long_flags ? '--strict' : '-S'
        when :expand
          long_flags ? '--expand' : '-x'
        when :no_source
          long_flags ? '--no-source' : '-s'
        when :no_profile
          long_flags ? '--no-profile' : '-P'
        when :format
          long_flags ? '--format' : '-f'
        when :output
          long_flags ? '--out' : '-o'
      end
    end

  end
end
