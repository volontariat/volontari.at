Given /^a product named "([^\"]*)"$/ do |name|
  attributes = {name: name}
  attributes[:user_id] ||= @me.id if @me
  attributes[:area_ids] ||= [Area.last.id] if Area.any?
    
  @product = Factory(:product, attributes)
  
  @product.reload
end

Then /^I should see the following products:$/ do |expected_table|
  rows = find('table').all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end
