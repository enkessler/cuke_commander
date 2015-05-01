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

  Scenario: Flags default to short flags
    When  I want a cucumber command line with the following tags
      | @tag_1 |
    And I ask for the command line without specifying a flag type
    Then  I am given the following cucumber command line
      | cucumber -t @tag_1 |

  Scenario Outline: Profile flag format
    When  I want a cucumber command line with the following profiles
      | profile_1 |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <profile> profile_1 |
    When  I want a cucumber command line with the following profiles
      | profile_2 |
      | profile_3 |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <profile> profile_2 <profile> profile_3 |
  Examples:
    | short_long | profile   |
    | short      | -p        |
    | long       | --profile |

  Scenario Outline: No-profile flag format
    When  I want a cucumber command line with a no-profile flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag         |
    | short      | -P           |
    | long       | --no-profile |

  Scenario Outline: Tag flag format
    When  I want a cucumber command line with the following tags
      | @tag_1 |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> @tag_1 |
    When  I want a cucumber command line with the following tags
      | @tag_2       |
      | @tag_3,@tag4 |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> @tag_2 <flag> @tag_3,@tag4 |
  Examples:
    | short_long | flag   |
    | short      | -t     |
    | long       | --tags |

  Scenario: File-path flag format
    When  I ask for a cucumber command line with the following file-paths
      | features/common |
    Then  I am given the following cucumber command line
      | cucumber features/common |
    When  I ask for a cucumber command line with the following file-paths
      | features/some_dir       |
      | features/some_other_dir |
    Then  I am given the following cucumber command line
      | cucumber features/some_dir features/some_other_dir |

  Scenario Outline: Exclude pattern flag format
    When  I want a cucumber command line with the following exclude patterns
      | pattern_1 |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> pattern_1 |
    When  I want a cucumber command line with the following exclude patterns
      | pattern_2 |
      | pattern_3 |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> pattern_2 <flag> pattern_3 |
  Examples:
    | short_long | flag      |
    | short      | -e        |
    | long       | --exclude |

  Scenario Outline: No-source flag format
    When  I want a cucumber command line with a no-source flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag        |
    | short      | -s          |
    | long       | --no-source |

  Scenario Outline: No-color flag format
    When  I want a cucumber command line with a no-color flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag       |
    | short      | --no-color |
    | long       | --no-color |

  Scenario Outline: Color flag format
    When  I want a cucumber command line with a color flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag    |
    | short      | -c      |
    | long       | --color |

  Scenario Outline: Formatter flag format
    When  I want a cucumber command line with the following formatters
      | formatter | output_location |
      | json      | STDOUT          |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <format_flag> json <output_flag> STDOUT |
    When  I want a cucumber command line with the following formatters
      | formatter | output_location |
      | pretty    |                 |
      | html      | output.html     |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <format_flag> pretty <format_flag> html <output_flag> output.html |
  Examples:
    | short_long | format_flag | output_flag |
    | short      | -f          | -o          |
    | long       | --format    | --out       |

  Scenario Outline: Backtrace flag format
    When  I want a cucumber command line with a backtrace flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag        |
    | short      | -b          |
    | long       | --backtrace |

  Scenario Outline: Dry run flag format
    When  I want a cucumber command line with a dry run flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag      |
    | short      | -d        |
    | long       | --dry-run |

  Scenario Outline: Guess flag format
    When  I want a cucumber command line with a guess flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag    |
    | short      | -g      |
    | long       | --guess |

  Scenario Outline: WIP flag format
    When  I want a cucumber command line with a wip flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag  |
    | short      | -w    |
    | long       | --wip |

  Scenario Outline: Quiet flag format
    When  I want a cucumber command line with a quiet flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag    |
    | short      | -q      |
    | long       | --quiet |

  Scenario Outline: Help flag format
    When  I want a cucumber command line with a help flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag   |
    | short      | -h     |
    | long       | --help |

  Scenario Outline: Version flag format
    When  I want a cucumber command line with a version flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag      |
    | short      | --version |
    | long       | --version |


  Scenario Outline: Strict flag format
    When  I want a cucumber command line with a strict flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag     |
    | short      | -S       |
    | long       | --strict |

  Scenario Outline: Verbose flag format
    When  I want a cucumber command line with a verbose flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag      |
    | short      | -v        |
    | long       | --verbose |

  Scenario Outline: Expand flag format
    When  I want a cucumber command line with a expand flag
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> |
  Examples:
    | short_long | flag     |
    | short      | -x       |
    | long       | --expand |

  Scenario Outline: Name flag format
    When  I want a cucumber command line with the following names
      | pattern_1 |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> pattern_1 |
    When  I want a cucumber command line with the following names
      | pattern_2 |
      | pattern_3 |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> pattern_2 <flag> pattern_3 |
  Examples:
    | short_long | flag   |
    | short      | -n     |
    | long       | --name |

  Scenario Outline: Require flag format
    When  I want a cucumber command line with the following requires
      | features/foo.rb |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> features/foo.rb |
    When  I want a cucumber command line with the following requires
      | features/bar.rb     |
      | features/bar/baz.rb |
    And I ask for the command line with "<short_long>" flags
    Then  I am given the following cucumber command line
      | cucumber <flag> features/bar.rb <flag> features/bar/baz.rb |
  Examples:
    | short_long | flag      |
    | short      | -r        |
    | long       | --require |

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
