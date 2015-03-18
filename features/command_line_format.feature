Feature: Command line formatting

  As a person who uses fancy cucumber command lines
  I want to know command line formatting
  So I can get the right command line


  Background:
    Given a command line generator

  Scenario: Base format
    When  I ask for a cucumber command line with no additional options
    Then  I am given the following cucumber command line
      | cucumber |

  Scenario: Profile format
    When  I ask for a cucumber command line with the following profiles
      | profile_1 |
    Then  I am given the following cucumber command line
      | cucumber -p profile_1 |
    When  I ask for a cucumber command line with the following profiles
      | profile_2 |
      | profile_3 |
    Then  I am given the following cucumber command line
      | cucumber -p profile_2 -p profile_3 |

  Scenario: Tag format
    When  I ask for a cucumber command line with the following tags
      | @tag_1 |
    Then  I am given the following cucumber command line
      | cucumber -t @tag_1 |
    When  I ask for a cucumber command line with the following tags
      | @tag_2       |
      | @tag_3,@tag4 |
    Then  I am given the following cucumber command line
      | cucumber -t @tag_2 -t @tag_3,@tag4 |

  Scenario: File-path format
    When  I ask for a cucumber command line with the following file-paths
      | features/common |
    Then  I am given the following cucumber command line
      | cucumber features/common |
    When  I ask for a cucumber command line with the following file-paths
      | features/some_dir       |
      | features/some_other_dir |
    Then  I am given the following cucumber command line
      | cucumber features/some_dir features/some_other_dir |

  Scenario: Exclude-file format
    When  I ask for a cucumber command line with the following exclude-files
      | features/test1 |
    Then  I am given the following cucumber command line
      | cucumber -e features/test1 |
    When  I ask for a cucumber command line with the following exclude-files
      | features/test2 |
      | features/test3 |
    Then  I am given the following cucumber command line
      | cucumber -e features/test2 -e features/test3 |

  Scenario: No-source format
    When  I ask for a cucumber command line with a no-source flag
    Then  I am given the following cucumber command line
      | cucumber -s |

  Scenario: No-color format
    When  I ask for a cucumber command line with a no-color flag
    Then  I am given the following cucumber command line
      | cucumber --no-color |

  Scenario: Formatter format
    When  I ask for a cucumber command line with the following formatters
      | formatter | output_location |
      | json      | STDOUT          |
    Then  I am given the following cucumber command line
      | cucumber -f json -o STDOUT |
    When  I ask for a cucumber command line with the following formatters
      | formatter | output_location |
      | pretty    |                 |
      | html      | output.html     |
    Then  I am given the following cucumber command line
      | cucumber -f pretty -f html -o output.html |

  Scenario: Additional options format

  The additional options will be added to the end of the command line. This behavior allows for modifying
  the generated command line due to Cucumber options that this gem has not implemented or to handle possible
  extensions made to Cucumber by the user or, really, for any reason at all.

    When  I ask for a cucumber command line with the following additional options
      | --expand |
    Then  I am given the following cucumber command line
      | cucumber --expand |
    When  I ask for a cucumber command line with the following additional options
      | -d        |
      | fooBAR!!! |
    Then  I am given the following cucumber command line
      | cucumber -d fooBAR!!! |
