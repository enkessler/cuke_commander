namespace 'cuke_commander' do

  desc 'Check that things look good before trying to release'
  task :prerelease_check do
    puts Rainbow('Checking that gem is in a good, releasable state...').cyan

    Rake::Task['cuke_commander:full_check'].invoke
    # NOTE: The gem has no runtime dependencies. If it ever does, this task should be created and run here
    # Rake::Task['cuke_commander:check_dependencies'].invoke

    puts Rainbow("I'd ship it. B)").green
  end

end
