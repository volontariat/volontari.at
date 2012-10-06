module StateMachines::Story
  def self.included(base)
    base.extend ClassMethods
    
    base.class_eval do
      include Model::MongoDb::StateVersionAttributes
      
      attr_accessor :current_user
      
      const_set 'STATES', [:new, :active]
      const_set 'EVENTS', [:activate]
      
      state_machine :state, initial: :new do
        event :initialization do
          transition :new => :initialized
        end
        
        event :setup_tasks do
          transition :initialized => :tasks_defined  
        end
        
        state :tasks_defined do
          validate :valid_tasks, presence: true
        end
        
        event :activate do
          transition :tasks_defined => :active
        end
        
        event :complete do
          transition :active => :completed
        end
      end
      
      private
      
      def valid_tasks
        if tasks.select{|t| t.valid? }.none?
          errors[:base] << I18n.t(
            'activerecord.errors.models.story.attributes.base.missing_tasks'
          )
        end
      end
    end
  end
end