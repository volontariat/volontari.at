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
    When I delete a project
    Then I should see "Access denied"
    When I go to the projects page
    Then I should see the following projects:
      |Name | |
      |project 1| Actions | 
      |project 2| Actions | 
