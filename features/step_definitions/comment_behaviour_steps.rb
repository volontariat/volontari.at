When /^I fill out a comment form$/ do
  fill_in 'Subject', with: 'Comment 1'
  fill_in 'Text', with: 'Dummy 1'
end

When /^I fill out a comment's comment form$/ do
  fill_in 'Subject', with: 'Comment 2'
  fill_in 'Text', with: 'Dummy 2'
end

Then /^I should see the comment$/ do
  steps %{
    Then I should see "Comment 1"
    And I should see "Dummy 1"
  }
end

Then /^I should see the comment's comment$/ do
  page.should have_xpath(
    '//div[@class="nested_comments"]//div[@class="comment"]//div[@class="content"]//p',
    text: 'Dummy 2'
  )
end