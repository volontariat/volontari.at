# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
delivery_method_was = ActionMailer::Base.delivery_method
ActionMailer::Base.delivery_method = :test

db_seed = VolontariatSeed.new
db_seed.create_fixtures

ActionMailer::Base.delivery_method = delivery_method_was