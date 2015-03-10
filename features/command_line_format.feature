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
      | profile_2 |
    Then  I am given the following cucumber command line
      | cucumber -p profile_1 -p profile_2 |

  Scenario: Tag format
    When  I ask for a cucumber command line with the following tags
      | @tag_1 |
      | @tag_2 |
    Then  I am given the following cucumber command line
      | cucumber -t @tag_1 -t @tag_2 |

  Scenario: File-path format
    When  I ask for a cucumber command line with the following file-paths
      | features/common   |
      | features/some_dir |
    Then  I am given the following cucumber command line
      | cucumber features/common features/some_dir |

  Scenario: Exclude-file format
    When  I ask for a cucumber command line with the following exclude-files
      | features/test1 |
      | features/test2 |
    Then  I am given the following cucumber command line
      | cucumber -e features/test1 -e features/test2 |

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
      | pretty    |                 |
    Then  I am given the following cucumber command line
      | cucumber -f json -o STDOUT -f pretty |

  Scenario: Additional options format
    When  I ask for a cucumber command line with the following additional options
      | --expand |
      | -d       |
    Then  I am given the following cucumber command line
      | cucumber --expand -d |
