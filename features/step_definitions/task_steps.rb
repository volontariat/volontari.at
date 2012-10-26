module TaskFactoryMethods
  def new_task(name, options = {})
    factory = options[:factory] || :task
    attributes = options[:attributes] || {}
    
    attributes.merge!({name: name})
    set_task_defaults(attributes)
    @task = Factory(factory, attributes)
    @task.reload
    
    @task
  end
    
  def set_task_defaults(attributes)
    attributes[:story_id] ||= @story.id if @story && !attributes[:story_id]
  end
end

World(TaskFactoryMethods)

Given /^a task named "([^\"]*)"$/ do |name|
  new_task(name)
end

Then /^I should see the following tasks:$/ do |expected_table|
  rows = find('table').all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end
