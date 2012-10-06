Feature: Create a story
  In order to guide the user to the story creation workflow
  A project owner
  Wants to create a story
    
  @javascript
  Scenario: Create a story for no product
  
    Given a user named "user 1"
    And I log in as "user 1"
    And a project named "project 1"
    And I am on the new project story page
    When I fill in "Name" with "Story 1"
    And I fill in "Text" with "Dummy"
    And I press "Create Story"
    And I follow "Add Task"
    And I fill in the name field of the 1st task with "Task 1"
    And I fill in the text field of the 1st task with "Dummy 1"
    And I fill in the name field of the 2nd task with "Task 2"
    And I fill in the text field of the 2nd task with "Dummy 2"
    And I press "Update Tasks"
    Then I should see "Task 1"
    And I should see "Dummy 1"
    And I should see "Task 2"
    And I should see "Dummy 2"
    And I should see "Actions"