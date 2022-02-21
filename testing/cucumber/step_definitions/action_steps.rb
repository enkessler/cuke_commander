When(/^I ask for a cucumber command line$/) do
  @command_line = @commander.generate_command_line
end

When(/^I ask for a cucumber command line with no additional options$/) do
  @command_line = @commander.generate_command_line
end

When(/^I ask for a cucumber command line with the following file-paths$/) do |table|
  @options = {file_paths: table.raw.flatten}
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

And(/^I ask for the command line with "([^"]*)" flags$/) do |short_long|
  @command_line = if short_long == 'long'
                    @commander.generate_command_line(@options.merge({ :long_flags => true }))
                  else
                    @commander.generate_command_line(@options.merge({ :long_flags => false }))
                  end
end
