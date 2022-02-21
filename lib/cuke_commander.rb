require 'cuke_commander/version'
require 'cuke_commander/cl_generator'


# Top level module under which the gem code lives.
module CukeCommander

  # The Cucumber options that are currently supported by the gem.
  CUKE_OPTIONS = %w[long_flags profiles tags file_paths formatters excludes no_source no_color options backtrace
                    color dry_run expand guess help names no_profile quiet requires strict verbose version wip].freeze
end
