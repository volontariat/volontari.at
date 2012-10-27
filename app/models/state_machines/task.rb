module StateMachines::Task
  def self.included(base)
    base.extend ClassMethods
    
    base.class_eval do
      include Model::MongoDb::StateVersionAttributes
      
      attr_accessor :current_user
      
      const_set 'STATES', [:new, :assigned, :under_supervision, :completed]
      const_set 'EVENTS', [:assign, :cancel, :review, :follow_up, :complete]
      
      state_machine :state, initial: :new do
        event :assign do
          transition :new => :assigned
        end
        
        state :assigned do
          validates :user_id, presence: true
        end
        
        event :cancel do 
          transition :assigned => :new
        end
       
        event :review do
          transition :assigned => :under_supervision
        end
        
        state :under_supervision do
          # TODO: move logic of Workflow::TasksController#update here
          #validates_associated :result
        end
       
        event :follow_up do 
          transition [:under_supervision, :completed] => :assigned
        end
        
        event :complete do
          # TODO: complete the story through observer
          transition :under_supervision => :completed
        end
      end
    end
  end
end