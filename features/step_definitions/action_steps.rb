When(/^I ask for a cucumber command line$/) do
  @command_line = @commander.generate_command_line
end

When(/^I ask for a cucumber command line with profiles$/) do
  @options = {profiles: ['profile_1', 'profile_2']}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with no additional options$/) do
  @command_line = @commander.generate_command_line
end

When(/^I ask for a cucumber command line with the following profiles$/) do |profiles|
  options = {profiles: profiles.raw.flatten}
  @command_line = @commander.generate_command_line(options)
end

When(/^I ask for a cucumber command line with tags$/) do
  @options = {tags: ['@tag_1', '@tag_2']}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the following tags$/) do |tags|
  @options = {tags: tags.raw.flatten}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with file-paths$/) do
  @options = {file_paths: ['features/', 'features/']}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the following file-paths$/) do |table|
  @options = {file_paths: table.raw.flatten}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with exclude files$/) do
  @options = {exclude_files: ['features/test1', 'features/test2']}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the following exclude-files$/) do |table|
  @options = {exclude_files: table.raw.flatten}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a no-source flag$/) do
  @options = {no_source: [true]}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a no-color flag$/) do
  @options = {no_color: [true]}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with formatters$/) do
  @options = {formatters: {'json' => nil}}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the following formatters$/) do |table|
  table = table.raw
  table.shift

  @options = {formatters: Hash[table]}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with (container|non-container) options$/) do |container_or_not|
  container_or_not == 'container' ? options = {:tags => [1, 2, 3]} : options = {tags: '1', profiles: '2'}

  begin
    @error = false
    @commander.generate_command_line(options)
  rescue ArgumentError => e
    @error_msg = e.message
    @error = true
  end
end

When(/^I ask for a cucumber command line with an invalid option$/) do
  options = {not_a_valid_option: 'some value'}

  begin
    @error = false
    @commander.generate_command_line(options)
  rescue ArgumentError => e
    @error_msg = e.message
    @error = true
  end
end

When(/^I ask for a cucumber command line with a valid option$/) do
  #todo - remove randomness by checking all cases down at the unit level
  option = @valid_options.sample
  options = {option.to_sym => ['some value']}

  begin
    @error = false
    @commander.generate_command_line(options)
  rescue ArgumentError => e
    @error_msg = e.message
    @error = true
  end
end

When(/I ask for a cucumber command line with the following additional options$/) do |options|
  @options = {options: options.raw.flatten}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with additional options$/) do
  @extra_options = ['-f', '--bar']
  @options = {options: @extra_options}

  @command_line = @commander.generate_command_line(@options)
end
