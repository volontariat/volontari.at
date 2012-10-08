class Workflow::User::TasksController < ApplicationController
  include Wizard::Controller
  
  wizard_steps :work, :review
  
  def next
    @story = Story.find(params[:story_id])
    @task = @story.next_task_for_user(current_user)
    
    if @task.is_a?(String) 
      redirect_to(
        product_workflow_user_index_path(@story.product_id), notice: @task
      )
    else
      redirect_to edit_task_workflow_user_index_path(@task) and return  
    end
  end
  
  def edit
    @task = Task.find(params[:id])
    @story = @task.story
    @result = @task.result || Result.new(task: @task)
    
    # increase level when there are more sub items for edit_task_workflow_user_index_path(@task))
    @twitter_sidenav_level = 6
    
    #raise [step, @task.state].inspect
  end
  
  def index
    @story = Story.find(params[:story_id])
    @tasks = @story.tasks
    
    # increase level when there are more sub items for tasks_workflow_user_index_path(@task))
    @twitter_sidenav_level = 4
  end
  
  def resource
    @task
  end
end