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

      %w(profiles names tags excludes requires).each do |option|
        append_options(command_line, wrap_options(options[option.to_sym]), flag_for(option.to_sym, options[:long_flags])) if options[option.to_sym]
      end
      append_options(command_line, wrap_options(options[:file_paths])) if options[:file_paths]
      append_option(command_line, flag_for(:no_source, options[:long_flags]))  if options[:no_source]

      if options[:formatters]
        options[:formatters].each do |format, output_location|
          append_option(command_line, format, flag_for(:format, options[:long_flags]))
          append_option(command_line, output_location,flag_for(:output, options[:long_flags])) unless output_location.to_s.empty?
        end
      end

      %w(no_color color backtrace dry_run no_profile guess wip quiet verbose version help expand strict).each do |option|
        append_option(command_line, flag_for(option.to_sym,options[:long_flags])) if options[option.to_sym]
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

      %w(Profiles Tags File\ paths Formatters Excludes No-source No-color Color Backtrace Expand Guess Help Dry\ run No\ profile Quiet Strict Verbose Version Wip Names Requires Options Long\ Flags).each do |option|
        option_string = option.gsub('-','_').gsub(' ','_').downcase
        option_symbol = option_string.to_sym
        raise_invalid_error(option, 'a String or Array', options[option_symbol]) unless self.send("valid_#{option_string}?", (options[option_symbol]))
      end
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

    string_array_valids = %w(profiles tags file_paths excludes names requires options)
    hash_valids = %w(formatters)
    boolean_valids = %w(no_source no_color color backtrace wip no_profile expand
                        strict verbose version quiet guess help dry_run long_flags)

    string_array_valids.each do |check_this|
      define_method("valid_#{check_this}?".to_sym) do |check_this|
        valid_string_array_value?(check_this)
      end
    end

    hash_valids.each do |check_this|
      define_method("valid_#{check_this}?".to_sym) do |check_this|
        valid_hash_value?(check_this)
      end
    end

    boolean_valids.each do |check_this|
      define_method("valid_#{check_this}?".to_sym) do |check_this|
        valid_boolean_value?(check_this)
      end
    end

    # def valid_profiles?(profiles)
    #   valid_string_array_value?(profiles)
    # end

    # def valid_tags?(tags)
    #   valid_string_array_value?(tags)
    # end

    # def valid_file_paths?(file_paths)
    #   valid_string_array_value?(file_paths)
    # end

    # def valid_formatters?(formatters)
    #   valid_hash_value?(formatters)
    # end

    # def valid_excludes?(excludes)
    #   valid_string_array_value?(excludes)
    # end

    # def valid_no_source?(no_source)
    #   valid_boolean_value?(no_source)
    # end

    # def valid_no_color?(no_color)
    #   valid_boolean_value?(no_color)
    # end

    # def valid_color?(color)
    #   valid_boolean_value?(color)
    # end

    # def valid_backtrace?(backtrace)
    #   valid_boolean_value?(backtrace)
    # end

    # def valid_wip?(wip)
    #   valid_boolean_value?(wip)
    # end

    # def valid_no_profile?(no_profile)
    #   valid_boolean_value?(no_profile)
    # end

    # def valid_expand?(expand)
    #   valid_boolean_value?(expand)
    # end

    # def valid_strict?(strict)
    #   valid_boolean_value?(strict)
    # end

    # def valid_verbose?(verbose)
    #   valid_boolean_value?(verbose)
    # end

    # def valid_version?(version)
    #   valid_boolean_value?(version)
    # end

    # def valid_quiet?(quiet)
    #   valid_boolean_value?(quiet)
    # end

    # def valid_guess?(guess)
    #   valid_boolean_value?(guess)
    # end

    # def valid_help?(help)
    #   valid_boolean_value?(help)
    # end

    # def valid_dry_run?(dry_run)
    #   valid_boolean_value?(dry_run)
    # end

    # def valid_names?(names)
    #   valid_string_array_value?(names)
    # end

    # def valid_requires?(requires)
    #   valid_string_array_value?(requires)
    # end

    # def valid_options?(options)
    #   valid_string_array_value?(options)
    # end

    # def valid_long_flags?(long_flag)
    #   valid_boolean_value?(long_flag)
    # end

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
