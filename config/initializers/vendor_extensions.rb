#Dir[Rails.root.join("lib/vendors/**/*.rb")].each {|f| require f}
require "#{Rails.root.to_s}/lib/vendors/active_model/naming.rb"
