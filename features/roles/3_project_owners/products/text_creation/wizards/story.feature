Feature: Create a story
  In order to guide the user to the story creation workflow
  A project owner
  Wants to create a story
    
  Scenario: Create a story for product Text Creation

    Given a user named "user 1"
    And I log in as "user 1"
    And a text creation project named "project 1"
    And I am on the new project story page
    When I fill in "Name" with "Story 1"
    And I select "English" from "Language"
    And I fill in "Min length" with "10"
    And I fill in "Max length" with "50"
    #And I check "With Keywords"
    #And I fill in "Min number of keywords" with "1"
    #And I fill in "Max number of keywords" with "3"
    And I fill in "Text" with "Dummy"
    And I press "Create Story"
    And I fill in the 1st field of "Name" with "Task 1"
    #And I fill in the 1st field of "Keywords" with "Keyword 1"
    And I press "Update Tasks"
    Then I should see "Task 1"
    #And I should see "Keyword 1"
    And I should see "Actions"