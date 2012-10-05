Feature: Manage candidatures
  In order to describe candidatures
  A guest
  Wants to add an candidature
  
  Background:
    
    Given a user named "user"
    And a project named "project 1"
    And a vacancy named "vacancy 1"
    And I log in as "user"
  
  Scenario: Register new candidature
    Given I am on the new candidature page
    When I select "vacancy 1" from "Vacancy"
    And I fill in "Name" with "candidature 1"
    And I fill in "Text" with "Dummy"
    And I press "Create Candidature"
    Then I should see "Creation successful"
    And I should see "candidature 1" 
    And I should see "Dummy"
    And I should see "vacancy 1"

  Scenario: Edit candidature
    Given a candidature named "candidature 1"
    When I go to the edit candidature page
    And I fill in "Text" with "Dummy 2"
    And I press "Update Candidature"
    Then I should see "Update successful"
    And I should see "Dummy 2"

  @javascript
  Scenario: Delete candidature
    Given a user named "user 2"
    And the following candidatures:
      | name | vacancy | user |
      | candidature 1 | vacancy 1 | user |
      | candidature 2 | vacancy 1 | user 2 |
    When I delete the 1st "candidature"
    Then I should see the following candidatures:
      | Name | User | Vacancy | Project | |
      | candidature 2 | user 2 | vacancy 1 | project 1 | Actions | 
