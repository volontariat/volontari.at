When  /^I delete a project$/ do
  steps %{
    Given the following projects:
      |name| user |
      |project 1| @me |
      |project 2| @me |
    When I delete the 1st project
  }
end