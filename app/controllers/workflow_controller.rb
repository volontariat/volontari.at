class WorkflowController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @twitter_sidenav_level = 2
  end
end