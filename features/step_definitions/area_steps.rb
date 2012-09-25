Given /^an area named "([^\"]*)"$/ do |name|
  # WORKAROUND: get rid of area query. Don't know why it doesn't work without (e.g. /roles/2_users/projects.feature)
  @area = Area.where(name: name).first || Factory(:area, name: name)
  @area.reload
end

#Given /^the following areas:$/ do |areas|
#  Area.create!(areas.hashes)
#end

When /^I delete the (\d+)(?:st|nd|rd|th) area$/ do |pos|
  visit areas_path
  
  within(:row, 1) { find(:xpath, ".//a[#{pos.to_i}]").click }
  
  page.execute_script 'window.confirm = function () { return true }'
  click_link I18n.t('general.destroy')
end

Then /^I should see the following areas:$/ do |expected_table|
  rows = find("table").all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end
