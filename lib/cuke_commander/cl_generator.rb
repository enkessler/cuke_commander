module CukeCommander
  class CLGenerator

    def generate_command_line(options = {})
      validate_options(options)
      command_line = 'cucumber'

      append_options(command_line, wrap_options(options[:profiles]), '-p')      if options[:profiles]
      append_options(command_line, wrap_options(options[:tags]), '-t')          if options[:tags]
      append_options(command_line, wrap_options(options[:file_paths]))          if options[:file_paths]
      append_options(command_line, wrap_options(options[:exclude_files]), '-e') if options[:exclude_files]
      append_option(command_line, '-s')                                         if options[:no_source]

      if options[:formatters]
        options[:formatters].each do |format, output_location|
          append_option(command_line, format, '-f')
          append_option(command_line, output_location, '-o') unless output_location.to_s.empty?
        end
      end

      append_option(command_line, '--no-color')                     if options[:no_color]
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
      raise_invalid_error('Excluded file', 'a String or Array', options[:exclude_files]) unless valid_exclude_files?(options[:exclude_files])
      raise_invalid_error('No-source', 'true or false', options[:no_source])             unless valid_no_source?(options[:no_source])
      raise_invalid_error('No-color', 'true or false', options[:no_color])               unless valid_no_color?(options[:no_color])
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
      profiles.nil? || profiles.is_a?(Array) || profiles.is_a?(String)
    end

    def valid_tags?(tags)
      tags.nil? || tags.is_a?(Array) || tags.is_a?(String)
    end

    def valid_file_paths?(file_paths)
      file_paths.nil? || file_paths.is_a?(Array) || file_paths.is_a?(String)
    end

    def valid_formatters?(formatters)
      formatters.nil? || formatters.is_a?(Hash)
    end

    def valid_exclude_files?(exclude_files)
      exclude_files.nil? || exclude_files.is_a?(Array) || exclude_files.is_a?(String)
    end

    def valid_no_source?(no_source)
      no_source.nil? || (no_source == true) || (no_source == false)
    end

    def valid_no_color?(no_color)
      no_color.nil? || (no_color == true) || (no_color == false)
    end

    def valid_options?(options)
      options.nil? || options.is_a?(Array) || options.is_a?(String)
    end

  end
end
