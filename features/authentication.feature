Feature: Authentication
  In order to authenticate
  An user
  Wants to sign up
  
  @javascript
  Scenario: Sign up
    Given I am on the root page
    When I follow "Authentication"
    And I follow "Sign up"
    And I fill in "Name" with "User1"
    And I fill in "First name" with "Mister"
    And I fill in "Last name" with "User"
    And I fill in "Email" with "user1@volontari.at"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I select "Germany" from "Country"
    And I select "English" from "Mother tongue"
    And I select "English" from "Interface language"
    And I press "Create User"
    #Then an email should have been sent from "no-reply@volontari.at" to "user1@volontari.at" with the subject "Confirmation instructions"
    #And that mail should have "Welcome user1@volontari.at" in the body
    Then I should see "A message with a confirmation link has been sent to your email address."
