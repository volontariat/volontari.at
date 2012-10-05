Feature: Manage areas
  In order to categorize projects
  An user
  wants to add an area
  
  Background:
  
    Given a user named "user"
    And I log in as "user"
  
  Scenario: Register new area
    Given I am on the new area page
    When I fill in "Name" with "name 1"
    And I press "Create"
    Then I should see "Creation successful"
    And I should see "name 1"

  Scenario: Edit area
    Then I can't edit areas

  Scenario: Delete area
    Then I can't delete areas