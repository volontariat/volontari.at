Given /^a product named "([^\"]*)"$/ do |name|
  attributes = {name: name}
  attributes[:user_id] ||= @me.id if @me
  attributes[:area_ids] ||= [Area.last.id] if Area.any?
    
  @product = Factory(:product, attributes)
  
  @product.reload
end

When /^I delete the (\d+)(?:st|nd|rd|th) product$/ do |pos|
  visit products_path
  
  within(:row, 1) { find(:xpath, ".//a[#{pos.to_i}]").click }
  
  page.execute_script 'window.confirm = function () { return true }'
  click_link I18n.t('general.destroy')
end

Then /^I should see the following products:$/ do |expected_table|
  rows = find('table').all('tr')
  table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expected_table.diff!(table)
end
