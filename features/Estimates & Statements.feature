
 @Estimates

Feature: Estimates

  @estimates_screen
  Scenario: Login to the App and selects Estimates & Statements option

    Given I login to the application
    Then I tap on lhn
    Then I tap on lhn options Estimates & Statements
    Then I should see the estimate screen



  @estimates_tabs
  Scenario Outline: Login to the App and selects Estimates & Statements option

    Given I login to the application
    Then I tap on lhn
    Then I tap on lhn options Estimates & Statements
    Then I should see the estimate screen
    Then I select option as <arg>
    Then I should see the selected screen Estimates

    Examples:
      |arg       |
      |Due       |
      |Processing|
      |Paid      |
      |Failed    |

