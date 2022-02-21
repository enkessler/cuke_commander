namespace 'cuke_commander' do

  desc 'Generate a Rubocop report for the project'
  task :rubocop do
    puts Rainbow('Checking for code style violations...').cyan

    completed_process = CukeCommander::CukeCommanderHelper.run_command(['bundle', 'exec', 'rubocop',
                                                                        '--format', 'fuubar',
                                                                        '--format', 'html', '--out', "#{ENV['CUKE_COMMANDER_REPORT_FOLDER']}/rubocop.html", # rubocop:disable Metrics/LineLength
                                                                        '-S', '-D'])

    raise(Rainbow('RuboCop found violations').red) unless completed_process.exit_code.zero?

    puts Rainbow('RuboCop is pleased.').green
  end

  desc 'Check pretty much everything'
  task :full_check do
    puts Rainbow('Performing full check...').cyan

    Rake::Task['cuke_commander:test_everything'].invoke
    Rake::Task['cuke_commander:check_documentation'].invoke
    Rake::Task['cuke_commander:rubocop'].invoke

    puts Rainbow('All is well. :)').green
  end

end
