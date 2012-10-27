Feature: Manage a task's transitions
  In order to handle a task's different states
  A project owner
  Wants to do transitions
  
  Background:
  
    Given a user named "Project Owner"
    And a text creation project named "Project 1"
    And a story without tasks named "Story 1"   
    And a user named "User"
  
  Scenario: Follow up
  
    Given a text creation task under supervision named "Task 1"
    When I log in as "Project Owner"
    And I go to the edit workflow task page
    And I press "Follow up"
    Then I should see "Follow up successful"
   
  Scenario: Complete task
  
    Given a text creation task under supervision named "Task 1"
    When I log in as "Project Owner"
    And I go to the edit workflow task page
    And I press "Complete"
    Then I should see "Complete successful"