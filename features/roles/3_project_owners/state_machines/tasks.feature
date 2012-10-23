Feature: Manage a task's transitions
  In order to handle a task's different states
  A project owner
  Wants to do transitions
  
  Background:
  
    Given a user named "Project Owner"
    And a story without tasks named "Story 1"   
    
  @javascript  
  Scenario: Unassign task
 
    Given a user named "User"
    And an assigned text creation task named "Task 1"
    When I log in as "Project Owner"
    And I go to the edit workflow task page
    And I press "cancel"
    Then I should see "Cancel successful"
   
  @javascript  
  Scenario: Complete task
  
    Given a user named "User"
    And a text creation task under supervision named "Task 1"
    When I log in as "Project Owner"
    And I go to the edit workflow task page
    And I press "complete"
    Then I should see "Complete successful"