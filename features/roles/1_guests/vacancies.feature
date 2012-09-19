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
  Scenario: Delete vacancies
    Given the following vacancies:
      |name | project |
      |vacancy 1 | project 1 |
    And I am on the vacancies page
    When I delete the 1st vacancy
    Then I should see "Access denied"
    When I go to the vacancies page
    Then I should see the following vacancies:
      |Name | Project | |
      | vacancy 1 | project 1 | Actions | 
