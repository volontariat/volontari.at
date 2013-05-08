module ProjectFactoryMethods
  def set_project_defaults(attributes)
    attributes[:user_id] ||= @me.id if @me && !attributes[:user_id]
    attributes[:product_id] ||= @product.id if @product && !attributes[:product_id]
    attributes[:area_ids] ||= [Area.last.id] if Area.any? && !attributes[:area_ids]
  end
end

World(ProjectFactoryMethods)

Given /^a project named "([^\"]*)"$/ do |name|
  attributes = {name: name}
  set_project_defaults(attributes)
  @project = FactoryGirl.create(:project, attributes)
  
  @project.reload
end

Given /^a text creation project named "([^\"]*)"$/ do |name|
  product = Product.where(name: 'Text Creation').first || FactoryGirl.create(:product)
  attributes = {name: name, product_id: product.id}
  set_project_defaults(attributes)
  @project = FactoryGirl.create(:project, attributes)
  
  @project.reload
end

Then /^I should see the following projects:$/ do |expected_table|
  rows = find('table').all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end
