# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cuke_commander/version'

Gem::Specification.new do |spec|
  spec.name          = "cuke_commander"
  spec.version       = CukeCommander::VERSION
  spec.authors       = ["Eric Kessler"]
  spec.email         = ["morrow748@gmail.com"]
  spec.description   = %q{Command Cucumber}
  spec.summary       = %q{Provides an easy way to build a cucumber commandline.}
  spec.homepage      = "https://github.com/grange-insurance/cuke_commander"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
