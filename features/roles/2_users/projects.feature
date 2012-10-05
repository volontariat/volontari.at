Feature: Manage projects
  In order to describe projects
  A guest
  Wants to add an project
  
  Background:
  
    Given a user named "user"
    And an area named "area 1"
    And I log in as "user"
  
  Scenario: Register new project
    Given I am on the new project page
    When I fill in "Name" with "name 1"
    And I fill in "Text" with "Dummy"
    And I check "area 1"
    And I press "Create"
    Then I should see "Creation successful"
    And I should see "name 1" 
    And I should see "Dummy"
    And I should see "area 1"

  Scenario: Edit project
    Given a project named "project 1"
    When I go to the edit project page
    And I fill in "Text" with "Dummy 2"
    And I press "Update Project"
    Then I should see "Update successful"
    And I should see "Dummy 2"

  @javascript
  Scenario: Delete project
    Given the following projects:
      |name| user |
      |project 1| @me |
      |project 2| @me |
    When I delete the 1st "project"
    Then I should see "Resource destroyed successfully"
    Then I should see the following projects:
      |Name | |
      |project 2| Actions | 
