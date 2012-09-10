module StateMachines::Vacancy
  def self.included(base)
    base.extend ClassMethods
    
    base.class_eval do
      attr_accessor :current_user
      
      const_set 'STATES', [:open, :recommended, :denied, :closed]
      const_set 'EVENTS', [:accept_recommendation, :deny_recommendation, :close, :reopen]
      
      state_machine :state, initial: :new do
        event :recommend do
          transition :new => :recommended 
        end
        
        event :accept_recommendation do
          transition :recommended => :open  
        end
        
        event :deny_recommendation do
          transition :recommended => :denied  
        end
        
        event :do_open do
          transition :new => :open 
        end
        
        event :close do
          transition :open => :closed
        end
        
        event :reopen do
          transition [:denied, :closed] => :open
        end
      end
    end
  end
  
  module ClassMethods
  end
end