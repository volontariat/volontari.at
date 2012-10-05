Then /^I can't edit areas$/ do
  steps %{
    Given an area named "area 1"
    When I go to the edit area page
    Then I should see "Access denied"
  }
end

Then /^I can't delete areas$/ do
  steps %{
    Given an area named "area 1" 
    When I am on the area page
    Then I should not see "Actions"
  }
end


