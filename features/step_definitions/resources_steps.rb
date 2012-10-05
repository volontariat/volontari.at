When /^I delete the (\d+)(?:st|nd|rd|th) "([^\"]*)"$/ do |pos, resource_name|
  visit eval("#{resource_name.pluralize}_path")

  within(:row, pos.to_i) { find(:xpath, ".//a[contains(text(), 'Actions')]").click }
  
  page.execute_script 'window.confirm = function () { return true }'
  click_link I18n.t('general.destroy')
end