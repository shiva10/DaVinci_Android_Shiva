@Login

  Feature: Login

    @login @select_no
    Scenario: Login to the App with valid credential first time and declining to save username details

      Given I am on the Login screen
      When I enter username as qaandroid
      And I enter password as 12345
      Then I tap on login button
      Then I tap on No button of popup message
      Then I should see the dashboard screen
      Then I tap on menu option in dashboard screen
      And  I tap on logout button
      Then I should see the blank user name and password text fields


    @login @select_yes
    Scenario: Login to the App with valid credential first time and saving username details

      Given I am on the Login screen
      When I enter username as qaandroid
      And I enter password as 12345
      Then I tap on login button
      Then I tap on Yes button of popup message
      Then I tap on menu option in dashboard screen
      And  I tap on logout button
      Then I should see the user name qaandroid prepopulated


    @login @login_valid
    Scenario: Login to the App with valid credentials

      Given I am on the Login screen
      When I enter username as qaandroid
      When I enter password as 12345
      Then I tap on login button
      Then I should see the dashboard screen
      Then I tap on menu option in dashboard screen
      Then I tap on logout button



    @login @login_valid_invalid_credentials
    Scenario Outline: Login to the App with invalid credentials

      Given I am on the Login screen
      When I enter the username as <username>
      And I enter the password as <password>
      Then I tap on login button
      Then I should see the message The combination of login and password is invalid.
      Then I tap on the DISSMISS button

    Examples:
    |username  |password   |
    |qaandro   |12345      |
    |qaandroid |123        |








