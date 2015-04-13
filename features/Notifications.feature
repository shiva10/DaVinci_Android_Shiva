@Notification

  Feature: Notifications

    @Notifications_Dashboard
    Scenario: As a user i want to see the notification information on dashboard if any

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the Notification list
      And I select the first notification
      And I navigate back to the dashboard

    @Notifications_Delete
    Scenario: As a user i want to delete the notification

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the Notification list
      And I select the first notification
      And I delete the notification

    @Notifications_Mark_as_unread
    Scenario: As a user i want to mark the notification as unread

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the Notification list
      And I select the first notification
      And I mark the notification as unread

    @No_Notifications_Dashboard
    Scenario: To verify the dashboard screen with no notifications

      Given I login to the application
      Then I should see the dashboard screen
      Then i must see the required text You have no notifications

    @Notifications_History
    Scenario: To verify the alert automatically removed from the queue after action is performed is moved into Alert History

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the Notification list
      And I select the first Notification
      Then I perform an action
      And I verify the notification is removed from the queue
      Then I verify the notification moved into notification history section

    @Notifications_Empty_History_section
    Scenario: To verify Notifications History section with no alerts

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the Notification list
      Then I navigate to Notification History section
      And I must see empty history page

    @Notifications_Page_Scroll
    Scenario: To verify the page scrolling

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the Notification list
      Then I scroll down the page

    @Notifications_History_Page_Scroll
    Scenario: To verify the page scrolling in history section

      Given I login to the application
      Then I should see the dashboard screen
      When I click on the Notification list
      Then I navigate to Notification History section
      Then I scroll down the page


