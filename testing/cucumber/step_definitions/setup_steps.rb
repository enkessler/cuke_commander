Given(/^a command line generator$/) do
  @commander = CukeCommander::CLGenerator.new
end

When(/^I want a cucumber command line with the following (?!formatters)([^ ]*)$/) do |option, values|
  @options = { option.to_sym => values.raw.flatten }
end

When(/^I want a cucumber command line with a (.*) flag$/) do |option|
  @options = { option.sub(/ |-/, '_').to_sym => true }
end

And(/^I ask for the command line without specifying a flag type$/) do
  @command_line = @commander.generate_command_line(@options)
end

When(/^I want a cucumber command line with the following exclude patterns$/) do |table|
  @options = { excludes: table.raw.flatten }
end

When(/^I want a cucumber command line with the following formatters$/) do |table|
  table = table.raw
  table.shift

  @options = { formatters: Hash[table] }
end
