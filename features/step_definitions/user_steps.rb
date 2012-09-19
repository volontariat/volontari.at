Given /^a user named "([^\"]*)"$/ do |name|
  @me = Factory(:user, name: name, email: "#{name}@volontari.at")
  @me.reload
end