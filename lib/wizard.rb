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
        @step = resource.try(:event).try(:to_sym)
        @step = @step ? next_step(@step) : wizard_steps.first 
      end
      
      @previous_step = previous_step(@step)
      @next_step = action_name.try(:to_sym) == @step ? @step : next_step(@step)
    end
  end
end