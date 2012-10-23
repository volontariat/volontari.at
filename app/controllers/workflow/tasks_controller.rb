class Workflow::TasksController < ApplicationController
  include Wizard::Controller
  
  wizard_steps :work, :review
  wizard_step_per_state work: [:assigned], review: [:under_supervision] 
  
  before_filter :resource, only: [:edit, :update]
  
  helper_method :resource
  
  def current_step_is_next_step_after_event
    false
  end
  
  def next
    story = Story.find(params[:story_id])
    task = story.next_task_for_user(current_user)
    
    if task.is_a?(String) 
      redirect_to(
        product_workflow_user_index_path(story.product_id), notice: task
      ) and return
    else
      redirect_to edit_task_workflow_user_index_path(task) and return  
    end
  end
  
  def edit
    @story = @task.story
    @task.result ||= Result.new(task: @task)
    @task.result.errors.clear
  end
  
  def update
    @task.attributes = params[:task]
    
    if params[:event] && params[:event].keys.select{|k| [:cancel, :skip].include?(k)}.any?
      unless @task.cancel
        render 'edit' and return
      end
      
      if params[:event][:cancel]
        notice = t("general.notifications.event_successful", event: I18n.t("tasks.general.events.cancel"))
        redirect_to(
          tasks_workflow_user_index_path(@task.story), notice: notice
        ) and return
      elsif params[:event][:skip]
        redirect_to(
          next_task_workflow_user_index_path(@task.story)
        ) and return
      end
    end
    
    method = params[:event] ? params[:event].keys.first : 'save'
    success = params[:next_step] == '1' || (params[:event] && params[:event][:next]) ? @task.send(step) : @task.send(method)
    
    render 'edit' and return unless success
    
    if success && params[:event] && params[:event][:next]
      redirect_to(
        next_task_workflow_user_index_path(@task.story), notice: t('general.form.successfully_updated')
      ) and return
    end
    
    notice = if method == 'save'
      t('general.form.successfully_updated')
    else
      t("general.notifications.event_successful", event: I18n.t("tasks.general.events.#{method}"))
    end
    
    if can? :edit, @task
      redirect_to(
        edit_task_workflow_user_index_path(@task), notice: notice
      )
    else
      redirect_to(
        tasks_workflow_user_index_path(@task.story), notice: t('general.form.successfully_updated')
      )
    end
  end
  
  def index
    @story = Story.find(params[:story_id])
    @tasks = @story.tasks
    
    # increase level when there are more sub items for tasks_workflow_user_index_path(@task))
    @twitter_sidenav_level = 4
  end
  
  def resource
    @task ||= Task.find(params[:id])
  end
end