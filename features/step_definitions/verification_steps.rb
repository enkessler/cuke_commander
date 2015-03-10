Then(/^I am given a cucumber command line$/) do
  expect(@command_line).to include("cucumber")
end

Then(/^I am given a cucumber command line with those profiles$/) do
  @options[:profiles].each do |profile|
    expect(@command_line).to include("-p #{profile}")
  end
end

Then(/^I am given the following cucumber command line$/) do |line|
  expect(@command_line).to eq(line.raw.flatten.first)
end

Then(/^I am given a cucumber command line with those tags$/) do
  @options[:tags].each do |tag|
    expect(@command_line).to include("-t #{tag}")
  end
end

Then(/^I am given a cucumber command line with those file-paths$/) do
  @options[:file_paths].each do |path|
    expect(@command_line).to include(path)
  end
end

Then(/^I am given a cucumber command line with those exclude files$/) do
  @options[:exclude_files].each do |file|
    expect(@command_line).to include(file)
  end
end

Then(/^I am given a cucumber command line with a no-source flag$/) do
  expect(@command_line).to include " -s"
end

Then(/^I am given a cucumber command line with a no-color flag$/) do
  expect(@command_line).to include " --no-color"
end

Then(/^I am given a cucumber command line with formatters$/) do
  expect(@command_line).to include " -f"
end

Then(/^I am given a cucumber command line with additional options$/) do
  @extra_options.each do |option|
    expect(@command_line).to include " #{option}"
  end
end

Then(/^The generator (will|will not) error$/) do |will_or_will_not|
  if will_or_will_not == 'will'
    raise("Expected error, did not error") unless @error
  else
    raise("Expected no error, but got: #{@error_msg}") if @error
  end
end
