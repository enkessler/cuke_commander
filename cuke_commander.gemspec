lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cuke_commander/version'

Gem::Specification.new do |spec|
  spec.name          = 'cuke_commander'
  spec.version       = CukeCommander::VERSION
  spec.authors       = ['Eric Kessler', 'Donavan Stanley']
  spec.email         = ['morrow748@gmail.com']
  spec.summary       = 'Command Cucumber'
  spec.description   = 'Provides an easy way to build a cucumber commandline.'
  spec.homepage      = 'https://github.com/enkessler/cuke_commander'
  spec.license       = 'MIT'
  spec.metadata      = {
    'bug_tracker_uri'   => 'https://github.com/enkessler/cuke_commander/issues',
    'changelog_uri'     => 'https://github.com/enkessler/cuke_commander/blob/master/CHANGELOG.md',
    'documentation_uri' => 'https://www.rubydoc.info/gems/cuke_commander',
    'homepage_uri'      => 'https://github.com/enkessler/cuke_commander',
    'source_code_uri'   => 'https://github.com/enkessler/cuke_commander'
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('', __dir__)) do
    source_controlled_files = `git ls-files -z`.split("\x0")
    source_controlled_files.keep_if { |file| file =~ /^(?:lib)/ }
    source_controlled_files + ['README.md', 'LICENSE.txt', 'CHANGELOG.md', 'cuke_commander.gemspec']
  end

  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0', '< 4.0'

  spec.add_development_dependency 'bundler', '< 3.0'
  spec.add_development_dependency 'childprocess', '< 5.0'
  spec.add_development_dependency 'rainbow', '< 4.0.0'
  spec.add_development_dependency 'rake', '< 13.0.0'
  spec.add_development_dependency 'cucumber', '< 8.0.0'
  spec.add_development_dependency 'rubocop', '<= 0.50.0' # RuboCop can not lint against Ruby 2.0 after this version
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '< 1.0.0'
  spec.add_development_dependency 'simplecov-lcov', '< 1.0'
  spec.add_development_dependency 'yard', '< 1.0'
end
