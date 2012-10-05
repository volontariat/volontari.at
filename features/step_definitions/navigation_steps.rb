When /^I click the (\d+)(?:st|nd|rd|th) link of the (\d+)(?:st|nd|rd|th) row$/ do |link_position, row_position|
  within(:row, row_position.to_i) { find(:xpath, ".//a[#{link_position.to_i}]").click }
end