@Alert

  Feature: Alerts

    @alerts_dashboard
    Scenario: As a user I want to see the alerts information on dashboard if any

      Given I login to the application
      Then I should see the dashboard screen
      Then I click on the alerts count
      Then I should be in the Alerts section
      And I select the first Alert

    @Alert_Perform_Action_1
    Scenario: As a user i want to perform an action on the alert
      Given I login to the application
      Then I should see the dashboard screen
      When I click on the alerts count
      And I select the first Alert
      And I perform an action

    @Alert_Perform_Action_2
    Scenario: To verify the alert automatically removed from the queue after action is performed

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the alerts count
      And I select the first Alert
      Then I perform an action
      And I verify the alert is removed from the queue

    @Alert_History
    Scenario: To verify the alert automatically removed from the queue after action is performed is moved into Alert History

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the alerts count
      And I select the first Alert
      Then I perform an action
      And I verify the alert is removed from the queue
      Then I verify the alert moved into alert history section

    @Alert_Empty_History_section
    Scenario: To verify Alert History section with no alerts

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the alerts count
      Then I navigate to Alert History section
      And I must see empty history page

    @Alert_View_Action_Taken_Alerts
    Scenario: As a Patient I want to be able to View the Alerts I have already taken an action on so that I can see what I have done and keep records.

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the alerts count
      Then I navigate to Alert History section
      And I must see a queue of alerts
      Then I click on any of the alert and view the details

    @No_Alerts_Dashboard
    Scenario: To verify the dashboard screen with no alerts

      Given I login to the application
      Then I should see the dashboard screen
      Then i must see the required text You have no alerts

    @Alerts_Page_Scroll
    Scenario: To verify the page scrolling

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the alerts count
      Then I scroll down the page

    @Alerts_History_Page_Scroll
    Scenario: To verify the page scrolling in history section

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the alerts count
      Then I navigate to Alert History section
      Then I scroll down the page




