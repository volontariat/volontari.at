class Workflow::UserController < ApplicationController
  def index
    @assigned_tasks = Task.assigned.where(user_id: current_user.id)
    @completed_tasks = Task.complete.where(user_id: current_user.id)
  end
end