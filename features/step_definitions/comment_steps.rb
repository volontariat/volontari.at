Given /^a comment$/ do
  attributes = { commentable: @project || @vacancy || @candidature }
  attributes[:user_id] ||= @me.id if @me
  @comment = Factory(:comment, attributes)
  @comment.reload
end

When /^I reply the (\d+)(?:st|nd|rd|th) comment$/ do |pos|
  find(:xpath, "//a[@class='new_comment'][#{pos.to_i}]").click
end

When /^I edit the (\d+)(?:st|nd|rd|th) comment$/ do |pos|
  find(:xpath, "//a[@class='edit_comment'][#{pos.to_i}]").click
end

When /^I delete the (\d+)(?:st|nd|rd|th) comment$/ do |pos|
  page.execute_script 'window.confirm = function () { return true }'
  find(:xpath, "//a[@class='destroy_comment'][#{pos.to_i}]").click
end

Then /^I should see the following comments:$/ do |expected_table|
  expected_table.hashes.each do |hash|
    steps %{Then I should see "#{hash['Name']}"}
  end  
end