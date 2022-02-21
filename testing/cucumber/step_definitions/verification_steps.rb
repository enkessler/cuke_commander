Then(/^I am given a cucumber command line$/) do
  expect(@command_line).to include('cucumber')
end

Then(/^I am given the following cucumber command line$/) do |line|
  expect(@command_line).to eq(line.raw.flatten.first)
end

Then(/^the generator (will|will not) error$/) do |will_or_will_not|
  if will_or_will_not == 'will'
    raise('Expected error, did not error') unless @error_encountered
  elsif @error_encountered
    raise("Expected no error, but got: #{@error_message}")
  end
end

And(/^The following Cucumber options are available for use:$/) do |valid_options|
  expect(CukeCommander::CUKE_OPTIONS).to match_array(valid_options.raw.flatten)
end
