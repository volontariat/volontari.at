When /I click on the tab "([^"]*)"/ do |tab|
  page.execute_script("$('a[href=\"##{tab.strip}\"]').click()")
end

When /I click on the (\d+)(?:st|nd|rd|th) link of a tab "([^"]*)"/ do |pos, tab|
  find(:xpath, "id('#{tab}')//a[#{pos.to_i}]").click
end