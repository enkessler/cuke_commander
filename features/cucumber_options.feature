Feature: Cucumber options

  As a person who uses fancy cucumber command lines
  I want to know about the available cucumber options
  So that I can use them correctly


  Scenario: Available Cucumber options
    * The following Cucumber options are available for use:
      | profiles      |
      | tags          |
      | file_paths    |
      | exclude_files |
      | no_source     |
      | formatters    |
      | no_color      |
      | options       |

  Scenario: Generator will accept known options
    Given a command line generator
    When  I ask for a cucumber command line with a valid option
    Then  the generator will not error

  Scenario: Unknown options trigger an error
    Given a command line generator
    When  I ask for a Cucumber command line with an invalid option
    Then  the generator will error

  Scenario: Invalid option values trigger an error
    Given a command line generator
    When  I ask for a Cucumber command line with an invalid option value
    Then  the generator will error
