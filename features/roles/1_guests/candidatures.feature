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
  Scenario: Delete candidature
    Given a candidature named "candidature 1"
    When I am on the candidature page
    Then I should not see "Actions"