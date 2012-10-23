Given /^an assigned text creation task named "([^\"]*)"$/ do |name|
  new_task(name, factory: :text_creation_task, attributes: { state: 'assigned' })
end

Given /^a text creation task under supervision named "([^\"]*)"$/ do |name|
  task = new_task(name, factory: :text_creation_task, attributes: { state: 'assigned' })
  Factory(:result, task_id: task.id, text: 'Dummy')
  task.review!
end