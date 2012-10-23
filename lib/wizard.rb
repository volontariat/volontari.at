module Wizard
  module Controller
    extend ActiveSupport::Concern 
    
    include Concerns::Steps
    include Concerns::Paths
    
    included do
      # Set step variables
      before_filter :setup_wizard, only: [:new, :create, :edit, :update]
    end
    
    private
    
    def setup_wizard
      @step  = action_name.try(:to_sym)
      
      unless wizard_steps.include? @step
        @step = nil
        
        step_from_event unless step_from_state
        
        @step = wizard_steps.first unless @step
      end
      
      
      
      @previous_step = previous_step(@step)
      @next_step = action_name.try(:to_sym) == @step ? @step : next_step(@step)
    end
    
    def step_from_state
      return false unless wizard_step_per_state.is_a?(Hash)
       
      state = resource.try(:state).try(:to_sym)
      
      return false unless state
      
      wizard_step_per_state.each do |step,states|
        if states.include?(state)
          @step = step
          break
        end
      end
      
      return @step ? true : false    
    end
    
    # TODO: just for backward compatibility purposes 
    def step_from_event
      @step = resource.try(:event).try(:to_sym)
      
      if @step && (!self.respond_to?(:current_step_is_next_step_after_event) || current_step_is_next_step_after_event) 
        @step = next_step(@step)
      end
    end
  end
end