Feature: Command line generation

  As a person who uses fancy cucumber command lines
  I want to have them made for me
  In order to not have to build it myself on the fly


  Background:
    Given a command line generator

  Scenario: Can generate a command line
    When  I ask for a cucumber command line
    Then  I am given a cucumber command line

  Scenario: Can generate a command line with profiles
    When  I ask for a cucumber command line with profiles
    Then  I am given a cucumber command line with those profiles

  Scenario: Can generate a command line with tags
    When  I ask for a cucumber command line with tags
    Then  I am given a cucumber command line with those tags

  Scenario: Can generate a command line with file-path
    When  I ask for a cucumber command line with file-paths
    Then  I am given a cucumber command line with those file-paths

  Scenario: Can generate a command line with exclude files
    When  I ask for a cucumber command line with exclude files
    Then  I am given a cucumber command line with those exclude files

  Scenario: Can generate a command line with a no-source flag
    When  I ask for a cucumber command line with a no-source flag
    Then  I am given a cucumber command line with a no-source flag

  Scenario: Can generate a command line with a no-color flag
    When  I ask for a cucumber command line with a no-color flag
    Then  I am given a cucumber command line with a no-color flag

  Scenario: Can generate a command line with formatters
    When  I ask for a cucumber command line with formatters
    Then  I am given a cucumber command line with formatters

  Scenario: Can generate a command line with additional options
    When  I ask for a cucumber command line with additional options
    Then  I am given a cucumber command line with additional options
