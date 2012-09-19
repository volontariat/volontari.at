Feature: Read candidatures
  In order to describe candidatures
  A guest
  Wants to try to add an candidature
  
  Scenario: Register new candidature
    Given I am on the new candidature page
    Then I should see "Access denied"

  Scenario: Edit candidature
    Given a candidature named "candidature 1"
    When I go to the edit candidature page
    Then I should see "Access denied"

  @javascript
  Scenario: Delete candidatures
    Given the following candidatures:
      |name | vacancy |
      |candidature 1 | vacancy 1 |
    And I am on the candidatures page
    When I delete the 1st candidature
    Then I should see "Access denied"
    When I go to the candidatures page
    Then I should see the following candidatures:
      |Name | Vacancy | |
      | candidature 1 | vacancy 1 | Actions | 
