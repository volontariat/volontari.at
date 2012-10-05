Feature: Manage areas
  In order to categorize projects
  An master
  wants to manage areas
  
  Background:
  
    Given a user named "Master"
    And I log in as "Master"

  Scenario: Edit area
    Given an area named "area 1"
    When I go to the edit area page
    And I fill in "Name" with "area 2"
    And I press "Update Area"
    Then I should see "Update successful"
    And I should see "area 2"
    
  @javascript
  Scenario: Delete area
    Given the following areas:
      |name|
      |area 1|
      |area 2|
    When I delete the 1st "area"
    Then I should see "Resource destroyed successfully"
    Then I should see the following areas:
      |Name | Users Count | |
      |area 2 | 0 | Actions | 