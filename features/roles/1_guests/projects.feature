Feature: Read projects
  In order to describe projects
  A guest
  Wants to try to add an project
  
  Scenario: Register new project
    Given I am on the new project page
    Then I should see "Access denied"

  Scenario: Edit project
    Given a project named "project 1"
    When I go to the edit project page
    Then I should see "Access denied"

  @javascript
  Scenario: Delete projects
    Given a project named "project 1"
    When I am on the project page
    Then I should not see "Actions"
