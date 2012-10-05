Given /^an area named "([^\"]*)"$/ do |name|
  # WORKAROUND: get rid of area query. Don't know why it doesn't work without (e.g. /roles/2_users/projects.feature)
  @area = Area.where(name: name).first || Factory(:area, name: name)
  @area.reload
end

Then /^I should see the following areas:$/ do |expected_table|
  rows = find("table").all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end
