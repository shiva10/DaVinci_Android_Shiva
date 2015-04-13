@settings

Feature: Settings

  @remember_username_select_on
  Scenario: Login to the App and selects settings option and select remember username option

    Given I login to the application
    Then I tap on lhn
    Then I tap on lhn options Settings
    Then I should see the settings screen
    Then I tap on remember username as ON
    Then I tap on logout button in setting screen
    Then I should see the user name in the text field as qaandroid


  @remember_username_select_off
  Scenario: Login to the App and selects settings option and select remember username option

    Given I login to the application
    Then I tap on lhn
    Then I tap on lhn options Settings
    Then I should see the settings screen
    Then I tap on remember username as OFF
    Then I tap on logout button in setting screen
    Then I should not see the user name in the text field



  @appointment_prepay
  Scenario: Login to the App and selects settings option and select remember username option

    Given I login to the application
    Then I tap on lhn
    Then I tap on lhn options Settings
    Then I should see the settings screen
    Then I select appointment prePay option
    Then I tap on logout button in setting screen


  @appointment_prepay
  Scenario: Login to the App and selects settings option and select remember username option

    Given I login to the application
    Then I tap on lhn
    Then I tap on lhn options Settings
    Then I should see the settings screen
    Then I select appointment prePay option
  # Then I should see the appointment prePay screen
    Then I tap on logout button in setting screen

  @fill_form
  Scenario: Login to the App and selects settings option and select remember username option

    Given I login to the application
    Then I tap on lhn
    Then I tap on lhn options Settings
    Then I should see the settings screen
    Then I select  fill form option
  # Then I should see the fill from screen
    Then I tap on logout button in setting screen

  @provider_name
  Scenario: Login to the App and selects settings option and select remember username option

    Given I login to the application
    Then I tap on lhn
    Then I tap on lhn options Settings
    Then I should see the settings screen
    Then I should see the provider name as Davincian Technologies
    Then I tap on logout button in setting screen
