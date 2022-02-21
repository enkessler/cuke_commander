Basic stuff:
[![Gem Version](https://badge.fury.io/rb/cuke_commander.svg)](https://rubygems.org/gems/cuke_commander)
[![Project License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/mit-license.php)
[![Downloads](https://img.shields.io/gem/dt/cuke_commander.svg)](https://rubygems.org/gems/cuke_commander)

User stuff:
[![Yard Docs](http://img.shields.io/badge/Documentation-API-blue.svg)](https://www.rubydoc.info/gems/cuke_commander)

Developer stuff:
[![Build Status](https://github.com/enkessler/cuke_commander/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/enkessler/cuke_commander/actions/workflows/ci.yml?query=branch%3Amaster)
[![Coverage Status](https://coveralls.io/repos/github/enkessler/cuke_commander/badge.svg?branch=master)](https://coveralls.io/github/enkessler/cuke_commander?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/fd2e7728ef547bf02e9e/maintainability)](https://codeclimate.com/github/enkessler/cuke_commander/maintainability)

---


# CukeCommander

The cuke_commander gem provides an easy and programmatic way to build a command line for running Cucumber.

## Installation

Add this line to your application's Gemfile:

    gem 'cuke_commander'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cuke_commander

## Usage

    require 'cuke_commander'

    # Choose your Cucumber options
    cucumber_options = {tags: ['@tag1', '@tag2,@tag3'],
                        formatters: {json: 'json_output.txt',
                                     pretty: ''},
                        options: ['-r features']}

    # Use the generator to create an appropriate Cucumber command line
    clg = CukeCommander::CLGenerator.new
    command_line = clg.generate_command_line(cucumber_options)

    puts command_line
    # This will produce something along the lines of
    # cucumber -t @tag1 -t @tag2,@tag3 -f json -o json_output.txt -f pretty -r features

    # Use the command line to kick off Cucumber
    system(command_line)

Simple!

(see documentation for all implemented Cucumber options)

## Development and Contributing

See [CONTRIBUTING.md](https://github.com/enkessler/cuke_commander/blob/master/CONTRIBUTING.md)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
