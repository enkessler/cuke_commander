ENV['CUKE_COMMANDER_SIMPLECOV_COMMAND_NAME'] = 'cucumber_tests'

require 'simplecov'
require_relative 'common_env'

require_relative '../testing/cucumber/step_definitions/action_steps'
require_relative '../testing/cucumber/step_definitions/setup_steps'
require_relative '../testing/cucumber/step_definitions/verification_steps'
