# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cuke_commander/version'

Gem::Specification.new do |spec|
  spec.name          = "cuke_commander"
  spec.version       = CukeCommander::VERSION
  spec.authors       = ["Eric Kessler", 'Donavan Stanley']
  spec.email         = ["morrow748@gmail.com", 'stanleyd@grangeinsurance.com']
  spec.summary       = %q{Command Cucumber}
  spec.description   = %q{Provides an easy way to build a cucumber commandline.}
  spec.homepage      = "https://github.com/grange-insurance/cuke_commander"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

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
