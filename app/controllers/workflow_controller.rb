class WorkflowController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @vacancies = {}
    @candidatures = {}
    
    { vacancies: Vacancy::STATES, candidatures: Candidature::STATES }.each do |controller, states|
      states.each do |state|
        if controller == :vacancies
          eval("@#{controller}[state] = Vacancy.where(offeror_id: current_user.id, state: state).order('created_at DESC').limit(5)")
        else
          eval("@#{controller}[state] = current_user.offeror_#{controller}.where(state: state).limit(5)")
        end
      end
    end
  end
end