class ApplicationController < Voluntary::ApplicationController
  layout Proc.new { |controller| controller.request.xhr? ? 'facebox' : 'application' }
  
  def current_ability
    @current_ability ||= super.merge(Application::Ability.new(current_user, controller_namespace: current_namespace))
  end
end