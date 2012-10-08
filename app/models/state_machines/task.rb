module StateMachines::Task
  def self.included(base)
    base.extend ClassMethods
    
    base.class_eval do
      include Model::MongoDb::StateVersionAttributes
      
      attr_accessor :current_user
      
      const_set 'STATES', [:new]
      const_set 'EVENTS', [:assign, :review, :unassign, :complete]
      
      state_machine :state, initial: :new do
        event :assign do
          transition [:new, :under_supervision] => :assigned
        end
        
        state :assigned do
          validates :user_id, presence: true
        end
        
        event :review do
          transition :assigned => :under_supervision
        end
        
        event :unassign do
          # TODO: save history of task and initialize task with default values through observer
          # TODO: add user to task's blacklist through observer
          transition [:assigned, :under_supervision] => :new
        end
        
        event :complete do
          # TODO: complete the story through observer
          transition :under_supervision => :completed
        end
      end
    end
  end
end