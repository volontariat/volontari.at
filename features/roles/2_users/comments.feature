Feature: Read comments
  In order to read comments
  A guest
  Wants to try to add an comment
  
  Background:
    
    Given a user named "user"
    And a project named "project 1"
    And I log in as "user"
    
  Scenario: Add new comment
    Given I am on the project page
    When I fill out a comment form
    And I press "Create Comment"
    Then I should see "Creation successful"
    And I should see the comment 

  Scenario: Comment a comment
    Given a comment
    And I am on the project page
    When I reply the 1st comment
    And I fill out a comment's comment form
    And I press "Create Comment"
    Then I should see "Creation successful"
    And I should see the comment's comment 

  Scenario: Edit comment
    Given a comment
    When I go to the project page
    When I edit the 1st comment
    And fill in "Text" with "Dummy 2"
    And I press "Update Comment"
    Then I should see "Update successful"
    And I should see "Dummy 2"

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
