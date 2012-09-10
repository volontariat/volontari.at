class Workflow::CandidaturesController < ApplicationController
  def new
    state_action
  end
  
  def accepted
    state_action
  end
  
  def denied
    state_action
  end
  
  private
  
  def state_action
    @candidatures = current_user.offeror_candidatures.where(state: action_name).includes(:vacancy, :user)
    render 'candidatures/index'
  end
end