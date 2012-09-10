module Applicat::Mvc::Controller::TransitionActions
  extend ActiveSupport::Concern

  private
  
  def fire_event(event, pass_event_to_assignment = false)
    authorize! event, resource
    
    #if params[resource.class.name.underscore.to_sym]
    #  resource.trigger = params[resource.class.name.underscore.to_sym][:trigger]
    #end
    
    resource.send(event)
    
    if resource.errors.full_messages.any?
      redirect_to :back, alert: resource.errors.full_messages.join(',')
    else
      redirect_to :back, notice: I18n.t('general.form.successfully_updated')  
    end
  end
  
  module ClassMethods
    private
    
    def transition_actions(*actions)
      actions = actions.first.is_a?(Symbol) ? actions : actions.first
      
      actions.each do |action|  
        define_method action do
          alternative_transition = nil
         
          alternative_transition = send "before_#{action}" if self.respond_to?("before_#{action}")
          
          alternative_transition = alternative_transition.is_a?(Symbol) ? alternative_transition : nil
          
          fire_event(alternative_transition || action) and return
          
          send "after_#{action}" if self.respond_to?("after_#{action}")
        end
      end
    end
  end
end