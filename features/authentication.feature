Feature: Authentication
  In order to authenticate
  An user
  Wants to sign up
  
  Scenario: Sign up
    Given I am on the root page
    When I follow "Authentication"
    And I follow "Sign up"
    And I fill in "Name" with "User"
    And I fill in "First name" with "Mister"
    And I fill in "Last name" with "User"
    And I fill in "Email" with "user@volontari.at"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "You have signed up successfully."
