module Wizard::Controller::Concerns::Steps
  extend ActiveSupport::Concern
  
  included do
    # Give our Views helper methods!
    helper_method :step,   :next_step,          :wizard_steps,     :current_step?,
                  :past_step?,      :future_step?,     :previous_step?,
                  :next_step?, :last_step?
  end
  
  module ClassMethods
    private
    
    def wizard_steps(*wizard_steps)
      const_set 'WIZARD_STEPS', wizard_steps
      
      # TODO: clarify if we still need to generate actions when we have an update action and next_step trigger
      "::#{self.to_s}::WIZARD_STEPS".constantize.each do |wizard_step|  
        next if wizard_step == :initialization
        
        define_method wizard_step do
          setup_wizard
          
          send("before_#{wizard_step}") if self.respond_to?("before_#{wizard_step}")
          
          wizard_resource = wizard_resource_class_name.constantize.find(params[:id])
          resource_name = wizard_resource_class_name.underscore
          resource.attributes = params[resource_name.to_sym] if params[resource_name.to_sym]
          
          if @story.send(next_step)
            redirect_to eval("#{next_step}_#{resource_name}_path(resource)")
          else
            send("after_#{wizard_step}") if self.respond_to?("after_#{wizard_step}")
          end
        end
      end
    end
    
    def wizard_step_per_state(hash)
      const_set 'WIZARD_STEP_PER_STATE', hash
    end
  end

  def wizard_steps
    "#{controller_class_name}::WIZARD_STEPS".constantize
  end
  
  def wizard_step_per_state
    "#{controller_class_name}::WIZARD_STEP_PER_STATE".constantize rescue {}
  end
  
  def wizard_resource_class_name
    controller_name.classify
  end

  def jump_to(goto_step)
    @skip_to = goto_step
  end

  def skip_step
    @skip_to = @next_step
  end

  def step
    @step
  end

  # will return true if step passed in is the currently rendered step
  def current_step?(step_name)
    return false if step_name.nil? || step.nil?
    
    step == step_name
  end

  # will return true if the step passed in has already been executed by the wizard
  def past_step?(step_name)
    return false if wizard_steps.index(step).nil? || wizard_steps.index(step_name).nil?
    
    wizard_steps.index(step) > wizard_steps.index(step_name)
  end

  # will return true if the step passed in has already been executed by the wizard
  def future_step?(step_name)
    return false if wizard_steps.index(step).nil? || wizard_steps.index(step_name).nil?
    
    wizard_steps.index(step) < wizard_steps.index(step_name)
  end

  # will return true if the last step is the step passed in
  def previous_step?(step_name)
    return false if wizard_steps.index(step).nil? || wizard_steps.index(step_name).nil?
    
    wizard_steps.index(step) - 1  == wizard_steps.index(step_name)
  end

  # will return true if the next step is the step passed in
  def next_step?(step_name)
    return false if wizard_steps.index(step).nil? || wizard_steps.index(step_name).nil?
    
    wizard_steps.index(step) + 1  == wizard_steps.index(step_name)
  end
 
  def previous_step(current_step = nil)
    return @previous_step if current_step == nil
    
    index =  wizard_steps.index(current_step)
    step  =  wizard_steps.at(index - 1) if index.present? && index != 0
    step ||= wizard_steps.first
    
    step
  end

  def next_step(current_step = nil)
    return @next_step if current_step == nil
    
    index = wizard_steps.index(current_step)
    step  = wizard_steps.at(index + 1) if index.present?
    step  ||= :finish
    
    step
  end
  
  def last_step?(current_step = nil)
    current_step = current_step || step
    
    current_step == wizard_steps.last
  end
  
  private
  
  def controller_class_name
    name = self.to_s.gsub(/#|<|>|#/, '').split(':').select{|e| !e.blank? }
    name.pop
    name.join('::')
  end
end
