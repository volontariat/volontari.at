Given /^a text creation task named "([^\"]*)"$/ do |name|
  new_task(name, factory: :text_creation_task)
end

Given /^an assigned text creation task named "([^\"]*)"$/ do |name|
  attributes = { state: 'assigned' }
  attributes[:user_id] = @me.id if @me && !attributes[:user_id]
  attributes[:author_id] = @me.id if @me
  new_task(name, factory: :text_creation_task, attributes: attributes)
end

Given /^a text creation task under supervision named "([^\"]*)"$/ do |name|
  attributes = { state: 'assigned' }
  attributes[:user_id] = @me.id if @me && !attributes[:user_id]
  attributes[:author_id] = @me.id if @me
  task = new_task(name, factory: :text_creation_task, attributes: attributes)
  Product::TextCreation::Result.create(task_id: task.id, text: 'Dummy Dummy')
  task.review!
end