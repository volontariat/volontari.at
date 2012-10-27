Feature: Manage a vacancy transitions
  In order to handle a vacancy's different states
  A user
  Wants to do transitions
    
  @javascript  
  Scenario: Accept vacancy recommendations
  
    Given a user named "user 1"
    And I log in as "user 1"
    And a project named "project 1"
    And a user named "user 2"
    And a vacancy named "vacancy 1" with state "recommended"
    And I am on the project owner's workflow page
    When I click on the tab "recommended_vacancies"
    And I click on the 1st link of a tab "recommended_vacancies"
    And I follow "Accept recommendation"
    Then I should see "Update successful"
    And I should see "open"