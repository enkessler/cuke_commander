module CukeCommander
  class CLGenerator

    CUKE_OPTIONS = %w{ profiles tags file_paths formatters exclude_files no_source no_color options}


    def generate_command_line(options = {})
      validate_options(options)
      command_line = 'cucumber'

      options[:profiles].each       { |profile|   command_line << " -p #{profile}" }    if options[:profiles]
      options[:tags].each           { |tag|       command_line << " -t #{tag}" }        if options[:tags]
      options[:file_paths].each     { |path|      command_line << " #{path}" }          if options[:file_paths]
      options[:exclude_files].each  { |file|      command_line << " -e #{file}" }       if options[:exclude_files]
      options[:no_source].each      { |boolean|   command_line << ' -s' if boolean }    if options[:no_source]
      if options[:formatters]
      options[:formatters].each do     |format, output_location|
        command_line << " -f #{format}"
        command_line << " -o #{output_location}" unless output_location.to_s.empty?
        end
      end
      options[:no_color].each       { |boolean|   command_line << ' --no-color' if boolean }    if options[:no_color]
      options[:options].each        { |option|    command_line << " #{option}" }                if options[:options]

      command_line
    end


    private


    def validate_options(options)
      raise(ArgumentError, "Argument must be a Hash, got: #{options.class}")  unless options.is_a?(Hash)

      options.each_pair do |key,value|
        raise(ArgumentError, "Option: #{key}, is not a container")  unless (value.is_a?(Hash) || value.is_a?(Array))
        raise(ArgumentError, "Option: #{key}, is not a cucumber option")  unless CUKE_OPTIONS.include?(key.to_s)
      end
    end

  end
end
