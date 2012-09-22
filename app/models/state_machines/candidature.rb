module StateMachines::Candidature
  def self.included(base)
    base.extend ClassMethods
    
    base.class_eval do
      attr_accessor :current_user
      
      const_set 'STATES', [:new, :accepted, :denied]
      const_set 'EVENTS', [:accept, :deny, :quit]
      
      state_machine :state, initial: :new do
        event :accept do
          transition [:new, :denied] => :accepted
        end
        
        state :accepted do
          validate :candidatures_limit_not_reached
        end
        
        event :deny do
          transition :new => :denied
        end
        
        event :quit do
          transition :accepted => :denied
        end
      end
      
      private
      
      # state validations
      def candidatures_limit_not_reached
        if vacancy.limit == vacancy.candidatures.where(state: 'accepted').count
          errors[:state] << I18n.t('activerecord.errors.models.vacancy.attributes.limit.reached')
        end
      end
    end
  end
  
  module ClassMethods
  end
end