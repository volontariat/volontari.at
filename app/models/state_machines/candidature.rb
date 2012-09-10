module StateMachines::Candidature
  def self.included(base)
    base.extend ClassMethods
    
    base.class_eval do
      attr_accessor :current_user
      
      const_set 'STATES', [:new, :accepted, :denied]
      const_set 'EVENTS', [:accept, :deny, :quit]
      
      state_machine :state, initial: :new do
        event :accept do
          transition [:new, :denied] => :accepted, unless: lambda {|c| c.vacancy.limit == c.vacancy.candidatures.where(state: 'accepted').count }
        end
        
        event :deny do
          transition :new => :denied
        end
        
        event :quit do
          transition :accepted => :denied
        end
      end
    end
  end
  
  module ClassMethods
  end
end