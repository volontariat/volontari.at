Given /^a vacancy named "([^\"]*)"$/ do |name|
  attributes = {name: name}
  attributes[:project_id] ||= Project.last.id if Project.any?
  
  @vacancy = Factory(:vacancy, attributes)
  
  @vacancy.reload
end

When /^I delete the (\d+)(?:st|nd|rd|th) vacancy$/ do |pos|
  visit vacancies_path
  
  within(:row, 1) { find(:xpath, ".//a[#{pos.to_i}]").click }
  
  page.execute_script 'window.confirm = function () { return true }'
  click_link I18n.t('general.destroy')
end

Then /^I should see the following vacancies:$/ do |expected_table|
  rows = find('table').all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end
