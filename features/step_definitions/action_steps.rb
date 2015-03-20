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

When(/^I ask for a cucumber command line with a no\-profile flag$/) do
  @options = {no_profile: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the following tags$/) do |tags|
  @options = {tags: tags.raw.flatten}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the following file-paths$/) do |table|
  @options = {file_paths: table.raw.flatten}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the following exclude patterns$/) do |table|
  @options = {excludes: table.raw.flatten}
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

When(/^I ask for a cucumber command line with a color flag$/) do
  @options = {color: true}
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

When(/^I ask for a cucumber command line with a backtrace flag$/) do
  @options = {backtrace: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a dry run flag$/) do
  @options = {dry_run: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a guess flag$/) do
  @options = {guess: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a wip flag$/) do
  @options = {wip: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a quiet flag$/) do
  @options = {quiet: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a help flag$/) do
  @options = {help: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a version flag$/) do
  @options = {version: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a strict flag$/) do
  @options = {strict: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with a verbose flag$/) do
  @options = {verbose: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with an expand flag$/) do
  @options = {expand: true}
  @command_line = @commander.generate_command_line(@options)
end

When(/^I ask for a cucumber command line with the name patterns$/) do |names|
  options = {names: names.raw.flatten}
  @command_line = @commander.generate_command_line(options)
end

When(/^I ask for a cucumber command line with the following required files$/) do |requires|
  options = {requires: requires.raw.flatten}
  @command_line = @commander.generate_command_line(options)
end
