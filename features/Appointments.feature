@appointment

Feature: Appointments

  @Appointments_Dashboard
  Scenario: As a user i want to see the appointments information on dashboard if any

    Given I login to the application
    Then I should see the dashboard screen
    When I click on the Appointments list
    And I select the first Appointment

  @Appointment_History
  Scenario: As a Patient I want to be able to View the Appointments that have passed so I can see when I have gone to the Doctor and keep records.

    Given I login to the application
    Then I should see the dashboard screen
    When I click on the Appointments list
#  (few lines yet to be added)
    Then I navigate to Appointments History section
    Then I verify the appointment moved into Appointment history section

  @Appointment_Empty_History_section
  Scenario: To verify Alert History section with no appointments

    Given I login to the application
    Then I should see the dashboard screen
    When I click on the Appointments list
    Then I navigate to Appointments History section
    And I must see empty history page

  @No_Appointmentss_Dashboard
  Scenario: To verify the dashboard screen with no alerts

    Given I login to the application
    Then I should see the dashboard screen
    Then i must see the required text You have no appointments

  @Appointments_Page_Scroll
  Scenario: To verify the page scrolling

    Given I login to the application
    Then I should see the dashboard screen
    When I click on the Appointments list
    Then I scroll down the page

  @Appointments_History_Page_Scroll
  Scenario: To verify the page scrolling in history section

    Given I login to the application
    Then I should see the dashboard screen
    When I click on the Appointments list
    Then I navigate to Appointments History section
    Then I scroll down the page