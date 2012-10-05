Feature: Read vacancies
  In order to describe vacancies
  A guest
  Wants to try to add an vacancy
  
  Scenario: Register new vacancy
    Given I am on the new vacancy page
    Then I should see "Access denied"

  Scenario: Edit vacancy
    Given a vacancy named "vacancy 1"
    When I go to the edit vacancy page
    Then I should see "Access denied"

  @javascript
  Scenario: Delete vacancy
    Given a vacancy named "project 1"
    When I am on the vacancy page
    Then I should not see "Actions"
