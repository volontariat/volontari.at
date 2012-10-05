module VacancyFactoryMethods
  def set_vacancy_defaults(attributes)
    attributes[:user_id] ||= @me.id unless attributes[:user_id] || !@me
    attributes[:project_id] ||= Project.last.id unless attributes[:project_id] || Project.all.none?
  end
  
  def new_vacancy(name, state = nil)
    attributes = { name: name }
    attributes[:state] = state if state
    
    set_vacancy_defaults(attributes)
    
    @vacancy = Factory(:vacancy, attributes)
    @vacancy.reload
  end
end

World(VacancyFactoryMethods)

Given /^a vacancy named "([^\"]*)"$/ do |name|
  new_vacancy(name)
end

Given /^a vacancy named "([^\"]*)" with state "([^\"]*)"$/ do |name, state|
  new_vacancy(name, state)
end

Then /^I should see the following vacancies:$/ do |expected_table|
  rows = find('table').all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end
