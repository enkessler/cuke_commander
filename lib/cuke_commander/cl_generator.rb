module CukeCommander
  class CLGenerator

    def generate_command_line(options = {})
      validate_options(options)
      command_line = 'cucumber'

      if options[:profiles]
        options[:profiles] = [options[:profiles]] unless options[:profiles].is_a?(Array)
        options[:profiles].each { |profile| command_line << " -p #{profile}" }
      end

      if options[:tags]
        options[:tags] = [options[:tags]] unless options[:tags].is_a?(Array)
        options[:tags].each { |tag| command_line << " -t #{tag}" }
      end

      if options[:file_paths]
        options[:file_paths] = [options[:file_paths]] unless options[:file_paths].is_a?(Array)
        options[:file_paths].each { |path| command_line << " #{path}" }
      end

      if options[:exclude_files]
        options[:exclude_files] = [options[:exclude_files]] unless options[:exclude_files].is_a?(Array)
        options[:exclude_files].each { |file| command_line << " -e #{file}" }
      end

      command_line << ' -s' if options[:no_source]

      if options[:formatters]
        options[:formatters].each do |format, output_location|
          command_line << " -f #{format}"
          command_line << " -o #{output_location}" unless output_location.to_s.empty?
        end
      end

      command_line << ' --no-color' if options[:no_color]

      if options[:options]
        options[:options] = [options[:options]] unless options[:options].is_a?(Array)
        options[:options].each { |option| command_line << " #{option}" }
      end

      command_line
    end


    private


    def validate_options(options)
      raise(ArgumentError, "Argument must be a Hash, got: #{options.class}") unless options.is_a?(Hash)

      options.each_key do |option|
        raise(ArgumentError, "Option: #{option}, is not a cucumber option") unless CUKE_OPTIONS.include?(option.to_s)
      end

      raise(ArgumentError, "Profiles option must be a String or Array, got: #{options[:profiles].class}") if (options[:profiles] && (!(options[:profiles].is_a?(Array) || options[:profiles].is_a?(String))))
      raise(ArgumentError, "Tags option must be a String or Array, got: #{options[:tags].class}") if (options[:tags] && (!(options[:tags].is_a?(Array) || options[:tags].is_a?(String))))
      raise(ArgumentError, "File path option must be a String or Array, got: #{options[:file_paths].class}") if (options[:file_paths] && (!(options[:file_paths].is_a?(Array) || options[:file_paths].is_a?(String))))
      raise(ArgumentError, "Formatters option must be a Hash, got: #{options[:formatters].class}") if (options[:formatters] && (!options[:formatters].is_a?(Hash)))
      raise(ArgumentError, "Excluded file option must be a String or Array, got: #{options[:exclude_files].class}") if (options[:exclude_files] && (!(options[:exclude_files].is_a?(Array) || options[:exclude_files].is_a?(String))))
      raise(ArgumentError, "No-source option must be true or false, got: #{options[:no_source].class}") if (!options[:no_source].nil? && (!((options[:no_source] == true) || (options[:no_source] == false))))
      raise(ArgumentError, "No-color option must be true or false, got: #{options[:no_color].class}") if (!options[:no_color].nil? && (!((options[:no_color] == true) || (options[:no_color] == false))))
      raise(ArgumentError, "Options option must be a String or Array, got: #{options[:options].class}") if (options[:options] && (!(options[:options].is_a?(Array) || options[:options].is_a?(String))))
    end

  end
end
