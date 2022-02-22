module CukeCommander

  # The object responsible for generating Cucumber command lines.
  class CLGenerator # rubocop:disable Metrics/ClassLength # It's mostly just a couple of large hashes

    # Generates a Cucumber command line.
    #
    # Most option values are either an Array or a boolean value. In the case of the former, a
    # String can be used instead of an Array when only a single value is needed. Some option
    # values come in pairs (e.g. formatters and their output locations). These option values
    # are taken as a Hash where a key is the first part of the pair and the key's value is the
    # second part.
    #
    # @param options [Hash] the Cucumber options that the command line should include.
    def generate_command_line(options = {}) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/LineLength # It's as good as it's going to get right now
      validate_options(options)
      command_line = 'cucumber'

      options.each_pair do |option, values|
        next if (values == false) || # Don't append options that are explicitly rejected
                (option == :formatters) || # Formatters can have flag pairs, so they're handled separately
                (option == :long_flags) # Not actually an option, just a modifier for the rest of the options

        # Flag only options come in with a true value but don't have a value that needs to be added to the command line
        values = nil if values == true

        append_options(command_line,
                       values: wrap_values(values),
                       flag:   flag_for(option, options[:long_flags]))
      end

      if options[:formatters]
        options[:formatters].each do |format, output_location|
          append_option(command_line,
                        value: format,
                        flag:  flag_for(:format, options[:long_flags]))

          # Not all formatters come will also have an associated output redirection
          next if output_location.to_s.empty?

          append_option(command_line,
                        value: output_location,
                        flag:  flag_for(:output, options[:long_flags]))
        end
      end

      command_line
    end


    private


    def validate_options(options)
      raise(ArgumentError, "Argument must be a Hash, got: #{options.class}") unless options.is_a?(Hash)

      options.each_pair do |option, value|
        raise(ArgumentError, "Option: #{option}, is not a cucumber option") unless CUKE_OPTIONS.include?(option.to_s)

        validate_option(option, value)
      end
    end

    def validate_option(option_name, value) # rubocop:disable Metrics/MethodLength # It's just a big hash
      error_info = { profiles:   ['Profiles', 'a String or Array'],
                     tags:       ['Tags', 'a String or Array'],
                     file_paths: ['File path', 'a String or Array'],
                     formatters: ['Formatters', 'a Hash'],
                     excludes:   ['Excludes', 'a String or Array'],
                     no_source:  ['No-source', 'true or false'],
                     no_color:   ['No-color', 'true or false'],
                     color:      ['Color', 'true or false'],
                     backtrace:  ['Backtrace', 'true or false'],
                     expand:     ['Expand', 'true or false'],
                     guess:      ['Guess', 'true or false'],
                     help:       ['Help', 'true or false'],
                     dry_run:    ['Dry run', 'true or false'],
                     no_profile: ['No profile', 'true or false'],
                     quiet:      ['Quiet', 'true or false'],
                     strict:     ['Strict', 'true or false'],
                     verbose:    ['Verbose', 'true or false'],
                     version:    ['Version', 'true or false'],
                     wip:        ['Wip', 'true or false'],
                     names:      ['Names', 'a String or Array'],
                     requires:   ['Requires', 'a String or Array'],
                     options:    ['Options', 'a String or Array'],
                     long_flags: ['Long Flags', 'true or false'] }

      return if send("valid_#{option_name}?", value)

      raise_invalid_error(error_info[option_name].first, error_info[option_name].last, value)
    end

    def append_options(command, values: nil, flag: nil)
      values.each do |value|
        append_option(command, flag: flag, value: value)
      end
    end

    def append_option(command, flag: nil, value: nil)
      command << " #{flag}" if flag
      command << " #{value}" if value
    end

    def wrap_values(value_set)
      value_set.is_a?(Array) ? value_set : [value_set]
    end

    def raise_invalid_error(option, valid_types, value_used)
      raise(ArgumentError, "#{option} option must be #{valid_types}, got: #{value_used.class}")
    end

    %w[profiles tags file_paths excludes names requires options].each do |option|
      define_method("valid_#{option}?") { |check_this| valid_string_array_value?(check_this) }
    end

    %w[no_source no_color color backtrace wip no_profile expand
       strict verbose version quiet guess help dry_run long_flags].each do |option|
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

    def flag_for(option, long_flags) # rubocop:disable Metrics/MethodLength # It's just a big hash
      flags = { tags:       ['--tags', '-t'],
                profiles:   ['--profile', '-p'],
                names:      ['--name', '-n'],
                excludes:   ['--exclude', '-e'],
                requires:   ['--require', '-r'],
                backtrace:  ['--backtrace', '-b'],
                color:      ['--color', '-c'],
                no_color:   ['--no-color', '--no-color'],
                dry_run:    ['--dry-run', '-d'],
                guess:      ['--guess', '-g'],
                wip:        ['--wip', '-w'],
                quiet:      ['--quiet', '-q'],
                help:       ['--help', '-h'],
                verbose:    ['--verbose', '-v'],
                version:    ['--version', '--version'],
                strict:     ['--strict', '-S'],
                expand:     ['--expand', '-x'],
                no_source:  ['--no-source', '-s'],
                no_profile: ['--no-profile', '-P'],
                format:     ['--format', '-f'],
                output:     ['--out', '-o'],
                file_paths: [nil, nil], # File paths are appended 'as is', so there is no flag used
                options: [nil, nil] } # Extra options are appended 'as is', so there is no flag used

      if long_flags
        flags[option].first
      else
        flags[option].last
      end
    end

  end
end
