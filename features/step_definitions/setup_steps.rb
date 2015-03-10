Given(/^a command line generator$/) do
  @commander = CukeCommander::CLGenerator.new
end

And(/^a set of valid command line options:$/) do |options_table|
  @valid_options = options_table.raw.flatten
end
