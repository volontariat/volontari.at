When /^I confirm all future JS confirm dialogs on this page$/ do
  page.evaluate_script('window.confirm = function() { return true; }')
end

When /^I cancel all future JS confirm dialogs on this page$/ do
  page.evaluate_script('window.confirm = function() { return false; }')
end

When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept    
end

When /^I dismiss popup$/ do
  page.driver.browser.switch_to.alert.dismiss
end