# CukeCommander

<a href="https://travis-ci.org/djmiller7/cuke_commander"><img src="https://travis-ci.org/djmiller7/cuke_commander.svg?branch=master" /></a>


<a href="http://badge.fury.io/rb/cuke_commander"><img src="https://badge.fury.io/rb/cuke_commander.svg" alt="Gem Version" /></a>

<a href="https://codeclimate.com/github/grange-insurance/cuke_commander"><img src="https://codeclimate.com/github/grange-insurance/cuke_commander/badges/gpa.svg" /></a>

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

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cuke_commander/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
