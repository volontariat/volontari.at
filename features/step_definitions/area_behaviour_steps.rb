Then /^I can't edit areas$/ do
  steps %{
    Given an area named "area 1"
    When I go to the edit area page
    Then I should see "Access denied"
  }
end

Then /^I can't delete areas$/ do
  steps %{
    Given the following areas:
      |name|
      |area 1|
    When I delete the 1st area
    Then I should see "Access denied"
    When I go to the areas page
    Then I should see the following areas:
      |Name| Users Count | |
      |area 1| 0 | Actions | 
  }
end
