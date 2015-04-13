 ##Using CallServer class

   @registration
   Feature: Registration_DaVinci

    @valid
    @callserver_davinci
    Scenario: Login correctly and Logout 
    Then I login to davincian

    @valid
    @callserver
    Scenario: Check token 
    Then I check davincian token 

    @valid
    @callserver
    @activation
    Scenario: Get activation code
    Then I get activation code 

    @valid
    @callserver
    @verification
    Scenario: Get verification code
    Then I get verification code 

    @invalid
    @callserver
    @reset
    Scenario: Reset the user
    Then I reset the user

    @valid
    @callserver
    @test
    Scenario: Register with token activation code
    Given I am about to login
    Then I request to use an activation code
    Then I enter the activation code
    Then I activate the current code
    Then I press the verification code
    Then I verify the current code
    Then I enter a user name
    Then I enter a password
    Then I repeat the password
    Then I enter the pin
    Then I repeat the pin
    Then I submit
    Then I say yes if I'm asked to remember my username
    Then I should see the dashboard page