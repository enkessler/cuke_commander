require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'rspec/core/rake_task'


def set_cucumber_options(options)
  ENV['CUCUMBER_OPTS'] = options
end

def combine_options(set_1, set_2)
  set_2 ? "#{set_1} #{set_2}" : set_1
end


namespace 'cuke_commander' do

  task :clear_coverage do
    puts 'Clearing old code coverage results...'

    # Remove previous coverage results so that they don't get merged into the new results
    code_coverage_directory = File.join(File.dirname(__FILE__), 'coverage')
    FileUtils.remove_dir(code_coverage_directory, true) if File.exists?(code_coverage_directory)
  end

  desc 'Run all of the Cucumber features for the gem'
  task :features, [:command_options] do |_t, args|
    set_cucumber_options(combine_options('-t ~@wip -t ~@off', args[:command_options]))
  end
  Cucumber::Rake::Task.new(:features)

  desc 'Run all of the RSpec specifications for the gem'
  RSpec::Core::RakeTask.new(:specs, :command_options) do |t, args|
    t.rspec_opts = "-t ~wip -t ~off "
    t.rspec_opts << args[:command_options] if args[:command_options]
  end

  desc 'Test All The Things'
  task :test_everything, [:command_options] => [:clear_coverage] do |_t, args|
    Rake::Task['cuke_commander:specs'].invoke(args[:command_options])
    Rake::Task['cuke_commander:features'].invoke(args[:command_options])
  end


  task :default => :test_everything
end
