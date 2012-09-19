Feature: Read comments
  In order to read comments
  A guest
  Wants to try to add an comment
  
  Background:
    
    Given a project named "project 1"
  
  Scenario: Add new comment
    Given I am on the project page
    When I fill out a comment form
    And I press "Create Comment"
    Then I should see "Access denied"

  Scenario: Edit comment
    Given a comment
    When I go to the project page
    When I edit the 1st comment
    Then I should see "Access denied"

  @javascript
  Scenario: Delete comment
    Given the following comments:
      |name | commentable |
      |comment 1 | project 1 |
    And I am on the project page
    When I delete the 1st comment
    Then I should see "Access denied"
    When I go to the project page
    Then I should see the following comments:
      |Name | Project | |
      | comment 1 | project 1 | Actions | 
