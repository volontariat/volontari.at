When /^(?:|I )fill in the name field of the 1st task with "([^"]*)"$/ do |value|
  find(:xpath, '/html/body/div[2]/div/div/div[2]/div[2]/form/fieldset//input[1]').set(value)
end

When /^(?:|I )fill in the text field of the 1st task with "([^"]*)"$/ do |value|
  find(:xpath, '/html/body/div[2]/div/div/div[2]/div[2]/form/fieldset//textarea[1]').set(value)
end

When /^(?:|I )fill in the name field of the 2nd task with "([^"]*)"$/ do |value|
  find(:xpath, '/html/body/div[2]/div/div/div[2]/div[2]/form/div[3]/fieldset//input[1]').set(value)
end

When /^(?:|I )fill in the text field of the 2nd task with "([^"]*)"$/ do |value|
  find(:xpath, '/html/body/div[2]/div/div/div[2]/div[2]/form/div[3]/fieldset//textarea[1]').set(value)
end