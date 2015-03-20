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

  Scenario: Profile flag format
    When  I ask for a cucumber command line with the following profiles
      | profile_1 |
    Then  I am given the following cucumber command line
      | cucumber -p profile_1 |
    When  I ask for a cucumber command line with the following profiles
      | profile_2 |
      | profile_3 |
    Then  I am given the following cucumber command line
      | cucumber -p profile_2 -p profile_3 |

  Scenario: No-profile flag format
    When  I ask for a cucumber command line with a no-profile flag
    Then  I am given the following cucumber command line
      | cucumber -P |

  Scenario: Tag flag format
    When  I ask for a cucumber command line with the following tags
      | @tag_1 |
    Then  I am given the following cucumber command line
      | cucumber -t @tag_1 |
    When  I ask for a cucumber command line with the following tags
      | @tag_2       |
      | @tag_3,@tag4 |
    Then  I am given the following cucumber command line
      | cucumber -t @tag_2 -t @tag_3,@tag4 |

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

  Scenario: Exclude pattern flag format
    When  I ask for a cucumber command line with the following exclude patterns
      | pattern_1 |
    Then  I am given the following cucumber command line
      | cucumber -e pattern_1 |
    When  I ask for a cucumber command line with the following exclude patterns
      | pattern_2 |
      | pattern_3 |
    Then  I am given the following cucumber command line
      | cucumber -e pattern_2 -e pattern_3 |

  Scenario: No-source flag format
    When  I ask for a cucumber command line with a no-source flag
    Then  I am given the following cucumber command line
      | cucumber -s |

  Scenario: No-color flag format
    When  I ask for a cucumber command line with a no-color flag
    Then  I am given the following cucumber command line
      | cucumber --no-color |

  Scenario: Color flag format
    When  I ask for a cucumber command line with a color flag
    Then  I am given the following cucumber command line
      | cucumber --color |

  Scenario: Formatter flag format
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

  Scenario: Backtrace flag format
    When  I ask for a cucumber command line with a backtrace flag
    Then  I am given the following cucumber command line
      | cucumber -b |

  Scenario: Dry run flag format
    When  I ask for a cucumber command line with a dry run flag
    Then  I am given the following cucumber command line
      | cucumber -d |

  Scenario: Guess flag format
    When  I ask for a cucumber command line with a guess flag
    Then  I am given the following cucumber command line
      | cucumber -g |

  Scenario: WIP flag format
    When  I ask for a cucumber command line with a wip flag
    Then  I am given the following cucumber command line
      | cucumber -w |

  Scenario: Quiet flag format
    When  I ask for a cucumber command line with a quiet flag
    Then  I am given the following cucumber command line
      | cucumber -q |

  Scenario: Help flag format
    When  I ask for a cucumber command line with a help flag
    Then  I am given the following cucumber command line
      | cucumber -h |

  Scenario: Version flag format
    When  I ask for a cucumber command line with a version flag
    Then  I am given the following cucumber command line
      | cucumber --version |

  Scenario: Strict flag format
    When  I ask for a cucumber command line with a strict flag
    Then  I am given the following cucumber command line
      | cucumber -S |

  Scenario: Verbose flag format
    When  I ask for a cucumber command line with a verbose flag
    Then  I am given the following cucumber command line
      | cucumber -v |

  Scenario: Expand flag format
    When  I ask for a cucumber command line with an expand flag
    Then  I am given the following cucumber command line
      | cucumber -x |

  Scenario: Name flag format
    When  I ask for a cucumber command line with the name patterns
      | pattern_1 |
    Then  I am given the following cucumber command line
      | cucumber -n pattern_1 |
    When  I ask for a cucumber command line with the name patterns
      | pattern_2 |
      | pattern_3 |
    Then  I am given the following cucumber command line
      | cucumber -n pattern_2 -n pattern_3 |

  Scenario: Require flag format
    When  I ask for a cucumber command line with the following required files
      | features/foo.rb |
    Then  I am given the following cucumber command line
      | cucumber -r features/foo.rb |
    When  I ask for a cucumber command line with the following required files
      | features/bar.rb     |
      | features/bar/baz.rb |
    Then  I am given the following cucumber command line
      | cucumber -r features/bar.rb -r features/bar/baz.rb |

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
