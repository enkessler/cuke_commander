require 'simplecov-lcov'
require_relative 'cuke_commander_helper'

SimpleCov.command_name(ENV['CUKE_COMMANDER_SIMPLECOV_COMMAND_NAME'])

# Coveralls GitHub Action needs an lcov formatted file
SimpleCov::Formatter::LcovFormatter.config do |config|
  config.report_with_single_file = true
  config.lcov_file_name = 'lcov.info'
end

# Also making a more friendly HTML file
formatters = [SimpleCov::Formatter::HTMLFormatter]

major, minor = CukeCommander::CukeCommanderHelper.version_of('simplecov')

# The Lcov formatter needs at least version 0.18 of SimpleCov but earlier versions may be in use due to CI needs
unless (major == 0) && (minor < 18)
  formatters << SimpleCov::Formatter::LcovFormatter
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formatters)

SimpleCov.start do
  root __dir__
  coverage_dir "#{ENV['CUKE_COMMANDER_REPORT_FOLDER']}/coverage"

  # Not worried about coverage of development only code
  add_filter '/testing/'
  add_filter '/environments/'

  # Ignore results that are older than 5 minutes
  merge_timeout 300
end
