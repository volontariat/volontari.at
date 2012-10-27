module StateMachines::Page
  def self.included(base)
    base.extend ClassMethods
    
    base.class_eval do
      attr_accessor :current_user
      
      const_set 'STATES', [:active]
      const_set 'EVENTS', []
      
      state_machine :state, initial: :active do
      end
    end
  end
  
  module ClassMethods
  end
end