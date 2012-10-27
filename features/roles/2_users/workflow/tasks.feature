Feature: Manage a task's transitions
  In order to handle a task's different states
  An user
  Wants to do transitions
  
  Background:
  
    Given a user named "Project Owner"
    And a text creation project named "Project 1"
    And a story without tasks named "Story 1"   
    And a user named "User"
  
  Scenario: Cancel task
 
    Given an assigned text creation task named "Task 1"
    When I log in as "User"
    And I go to the edit workflow task page
    And I press "Cancel"
    Then I should see "Cancel successful"
  
  Scenario: Skip task
 
    Given a text creation task named "Task 2"
    And an assigned text creation task named "Task 1"
    When I log in as "User"
    And I go to the edit workflow task page
    And I press "Skip"
    Then I should see "Task 2"
    
  Scenario: Pull request
  
    Given an assigned text creation task named "Task 1"
    When I log in as "User"
    And I go to the edit workflow task page
    And I fill in "task_result_attributes_text" with "Dummy Dummy"
    And I press "Pull request"
    Then I should see "Pull request successful"