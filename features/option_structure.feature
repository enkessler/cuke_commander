Feature: Options Structure

  As a person who uses fancy cucumber command lines
  I want to know about options structure
  So I can use the right options


  Background:
    Given a command line generator
    And a set of valid command line options:
      | profiles      |
      | tags          |
      | file_paths    |
      | exclude_files |
      | no_source     |
      | formatters    |
      | no_color      |
      | options       |

  Scenario: Generator will error for an unknown option
    When  I ask for a cucumber command line with an invalid option
    Then  The generator will error

  Scenario: Generator will accept known options
    When  I ask for a cucumber command line with a valid option
    Then  The generator will not error

  Scenario: Generator will accept containers as option values
    When  I ask for a cucumber command line with container options
    Then  The generator will not error

  Scenario: Generator will error for an option value other than a container
    When  I ask for a cucumber command line with non-container options
    Then  The generator will error
