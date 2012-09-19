Feature: Read areas
  In order to categorize projects
  A guest
  wants to try to add an area
  
  Scenario: Register new area
    Given I am on the new area page
    Then I should see "Access denied"

  Scenario: Edit area
    Then I can't edit areas

  @javascript
  Scenario: Delete area
    Then I can't delete areas
