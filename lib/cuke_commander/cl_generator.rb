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

      append_options(command_line, wrap_options(options[:profiles]), '-p')      if options[:profiles]
      append_options(command_line, wrap_options(options[:names]), '-n')         if options[:names]
      append_options(command_line, wrap_options(options[:tags]), '-t')          if options[:tags]
      append_options(command_line, wrap_options(options[:file_paths]))          if options[:file_paths]
      append_options(command_line, wrap_options(options[:excludes]), '-e')      if options[:excludes]
      append_options(command_line, wrap_options(options[:requires]), '-r')      if options[:requires]
      append_option(command_line, '-s')                                         if options[:no_source]

      if options[:formatters]
        options[:formatters].each do |format, output_location|
          append_option(command_line, format, '-f')
          append_option(command_line, output_location, '-o') unless output_location.to_s.empty?
        end
      end

      append_option(command_line, '--no-color')                     if options[:no_color]
      append_option(command_line, '--color')                        if options[:color]
      append_option(command_line, '-b')                             if options[:backtrace]
      append_option(command_line, '-d')                             if options[:dry_run]
      append_option(command_line, '-P')                             if options[:no_profile]
      append_option(command_line, '-g')                             if options[:guess]
      append_option(command_line, '-w')                             if options[:wip]
      append_option(command_line, '-q')                             if options[:quiet]
      append_option(command_line, '-v')                             if options[:verbose]
      append_option(command_line, '--version')                      if options[:version]
      append_option(command_line, '-h')                             if options[:help]
      append_option(command_line, '-x')                             if options[:expand]
      append_option(command_line, '-S')                             if options[:strict]

      append_options(command_line, wrap_options(options[:options])) if options[:options]

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

    def valid_profiles?(profiles)
      valid_string_array_value?(profiles)
    end

    def valid_tags?(tags)
      valid_string_array_value?(tags)
    end

    def valid_file_paths?(file_paths)
      valid_string_array_value?(file_paths)
    end

    def valid_formatters?(formatters)
      valid_hash_value?(formatters)
    end

    def valid_excludes?(excludes)
      valid_string_array_value?(excludes)
    end

    def valid_no_source?(no_source)
      valid_boolean_value?(no_source)
    end

    def valid_no_color?(no_color)
      valid_boolean_value?(no_color)
    end

    def valid_color?(color)
      valid_boolean_value?(color)
    end

    def valid_backtrace?(backtrace)
      valid_boolean_value?(backtrace)
    end

    def valid_wip?(wip)
      valid_boolean_value?(wip)
    end

    def valid_no_profile?(no_profile)
      valid_boolean_value?(no_profile)
    end

    def valid_expand?(expand)
      valid_boolean_value?(expand)
    end

    def valid_strict?(strict)
      valid_boolean_value?(strict)
    end

    def valid_verbose?(verbose)
      valid_boolean_value?(verbose)
    end

    def valid_version?(version)
      valid_boolean_value?(version)
    end

    def valid_quiet?(quiet)
      valid_boolean_value?(quiet)
    end

    def valid_guess?(guess)
      valid_boolean_value?(guess)
    end

    def valid_help?(help)
      valid_boolean_value?(help)
    end

    def valid_dry_run?(dry_run)
      valid_boolean_value?(dry_run)
    end

    def valid_names?(names)
      valid_string_array_value?(names)
    end

    def valid_requires?(requires)
      valid_string_array_value?(requires)
    end

    def valid_options?(options)
      valid_string_array_value?(options)
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

  end
end
