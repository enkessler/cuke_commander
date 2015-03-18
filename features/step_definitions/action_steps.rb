When(/^I ask for a cucumber command line$/) do
  @command_line = @commander.generate_command_line
end

When(/^I ask for a cucumber command line with no additional options$/) do
  @command_line = @commander.generate_command_line
end

When(/^I ask for a cucumber command line with the following profiles$/) do |profiles|
  options = {profiles: profiles.raw.flatten}
  @command_line = @commander.generate_command_line(options)
end

When(/^I ask for a cucumber command line with the following tags$/) do |tags|
  @options = {tags: tags.raw.flatten}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the following file-paths$/) do |table|
  @options = {file_paths: table.raw.flatten}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the following exclude-files$/) do |table|
  @options = {exclude_files: table.raw.flatten}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a no-source flag$/) do
  @options = {no_source: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a no-color flag$/) do
  @options = {no_color: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the following formatters$/) do |table|
  table = table.raw
  table.shift

  @options = {formatters: Hash[table]}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a Cucumber command line with an invalid option value$/) do
  options = {:tags => :bad_tag_value}

  begin
    @error_encountered = false
    @commander.generate_command_line(options)
  rescue ArgumentError => e
    @error_message = e.message
    @error_encountered = true
  end
end

When(/^I ask for a Cucumber command line with an invalid option$/) do
  options = {not_a_valid_option: 'some value'}

  begin
    @error_encountered = false
    @commander.generate_command_line(options)
  rescue ArgumentError => e
    @error_message = e.message
    @error_encountered = true
  end
end

When(/^I ask for a cucumber command line with a valid option$/) do
  options = {tags: 'foo'}

  begin
    @error_encountered = false
    @commander.generate_command_line(options)
  rescue ArgumentError => e
    @error_message = e.message
    @error_encountered = true
  end
end

When(/I ask for a cucumber command line with the following additional options$/) do |options|
  @options = {options: options.raw.flatten}
  @command_line = @commander.generate_command_line(@options)
end
