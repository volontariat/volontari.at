Feature: Manage vacancies
  In order to describe vacancies
  A guest
  Wants to add an vacancy
  
  Background:
    
    Given a user named "user2"
    And a project named "project 2"
    And a user named "user"
    And a project named "project 1"
    And I log in as "user"
  
  Scenario Outline: Register new vacancy
    Given I am on the new vacancy page
    When I select "<project>" from "Project"
    And I fill in "Name" with "<name>"
    And I fill in "Text" with "Dummy"
    And I fill in "Limit" with "1"
    And I press "Create Vacancy"
    Then I should see "Creation successful"
    And I should see "<name>" 
    And I should see "Dummy"
    And I should see "<project>"
    And I should see "<state>"

    Examples:
      | project | name | state |
      | project 1 | vacancy 1 | open |
      | project 2 | vacancy 2 | recommended |

  Scenario: Edit vacancy
    Given a vacancy named "vacancy 1"
    When I go to the edit vacancy page
    And I fill in "Text" with "Dummy 2"
    And I press "Update Vacancy"
    Then I should see "Update successful"
    And I should see "Dummy 2"

  @javascript
  Scenario: Delete vacancy
    Given the following vacancies:
      |name | project |
      |vacancy 1 | project 1 |
      |vacancy 2 | project 1 |
    And I am on the vacancies page
    When I delete the 1st "vacancy"
    Then I should see "Resource destroyed successfully"
    Then I should see the following vacancies:
      |Name | Project | |
      | vacancy 2 | project 1 | Actions | 
