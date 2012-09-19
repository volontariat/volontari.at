module CandidatureFactoryMethods
  def set_candidature_defaults(attributes)
    attributes[:user_id] ||= @me.id unless attributes[:user_id] || !@me
    attributes[:vacancy_id] ||= Vacancy.last.id unless attributes[:vacancy_id] || Vacancy.all.none?
  end
end

World(CandidatureFactoryMethods)

Given /^a candidature named "([^\"]*)"$/ do |name|
  attributes = {name: name}
  
  set_candidature_defaults(attributes)
  
  @candidature = Factory(:candidature, attributes)
  
  @candidature.reload
end

When /^I delete the (\d+)(?:st|nd|rd|th) candidature$/ do |pos|
  visit candidatures_path
  
  within(:row, 1) { find(:xpath, ".//a[#{pos.to_i}]").click }
  
  page.execute_script 'window.confirm = function () { return true }'
  click_link I18n.t('general.destroy')
end

Then /^I should see the following candidatures:$/ do |expected_table|
  rows = find('table').all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end
