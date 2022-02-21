Feature: Command line generation

  As a person who uses fancy cucumber command lines
  I want to have them made for me
  In order to not have to build it myself on the fly


  Scenario: Can generate a command line
    Given a command line generator
    When  I ask for a cucumber command line
    Then  I am given a cucumber command line
