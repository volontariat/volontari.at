SimpleNavigation::Configuration.run do |navigation|  
  instance_exec navigation, &Voluntary::Navigation.code
end