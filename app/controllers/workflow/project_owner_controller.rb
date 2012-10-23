class Workflow::ProjectOwnerController < ApplicationController
  def index
    @stories = {}
    @tasks = {}
    @vacancies = {}
    @candidatures = {}
    
    { vacancies: Vacancy::STATES, candidatures: Candidature::STATES }.each do |controller, states|
      query = 'offeror_id = :user_id'
      query += ' OR author_id = :user_id' if controller == :vacancies
      query = "(#{query}) AND state = :state"
      
      states.each do |state|
        # eval("@#{controller}[state] = current_user.offeror_#{controller}.where(state: state).limit(5)")
        collection = controller.to_s.classify.constantize.where(
          query, user_id: current_user.id, state: state
        ).order('created_at DESC').limit(5)
        eval("@#{controller}[state] = collection")
      end
    end
    
    { stories: [:completed], tasks: [:under_supervision] }.each do |controller, states|
      states.each do |state|
        collection = controller.to_s.classify.constantize.where(
          offeror_id: current_user.id, state: state
        ).limit(5)
        eval("@#{controller}[state] = collection")
      end
    end
    
    @twitter_sidenav_level = 2
  end
end