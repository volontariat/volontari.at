module StateMachines::Story
  def self.included(base)
    base.extend ClassMethods
    
    base.class_eval do
      include Model::MongoDb::StateVersionAttributes
      
      attr_accessor :current_user
      
      const_set 'STATES', [:new, :tasks_defined, :active, :completed, :closed]
      const_set 'EVENTS', [:initialization, :setup_tasks, :activate, :complete]
      
      state_machine :state, initial: :new do
        event :initialization do
          transition :new => :initialized
        end
        
        event :setup_tasks do
          transition :initialized => :tasks_defined  
        end
        
        state :tasks_defined do
          validates_associated :tasks
        end
        
        event :activate do
          transition [:tasks_defined, :completed] => :active
        end
        
        event :complete do
          transition :active => :completed
        end
        
        event :close do
          transition :completed => :closed
        end
      end
    end
  end
end