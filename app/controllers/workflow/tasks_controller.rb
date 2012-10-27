class Workflow::TasksController < ApplicationController
  include Wizard::Controller
  
  wizard_steps :work, :review
  wizard_step_per_state work: [:assigned], review: [:under_supervision] 
  
  before_filter :build_result, only: [:edit, :cancel, :skip, :update]
  load_and_authorize_resource except: [:next]
  
  helper_method :resource
  
  def current_step_is_next_step_after_event
    false
  end
  
  def index
    @story = Story.find(params[:story_id])
    @tasks = @story.tasks
    
    # increase level when there are more sub items for tasks_workflow_user_index_path(@task))
    @twitter_sidenav_level = 4
  end
  
  def next
    story = Story.find(params[:story_id])
    task = story.next_task_for_user(current_user)
    product_id = story.product_id.blank? ? 'no-name' : story.product_id
    
    if task.is_a?(String) 
      redirect_to(
        product_workflow_user_index_path(product_id), notice: task
      ) and return
    elsif task
      redirect_to edit_task_workflow_user_index_path(task) and return  
    else
      redirect_to(
        product_workflow_user_index_path(product_id), 
        notice: I18n.t('workflow.user.tasks.next.unavailable')
      ) and return
    end
  end
  
  def edit
    @story = @task.story
  end
  
  def cancel
    if @task.cancel
      notice = I18n.t(
        "general.notifications.event_successful", 
        event: I18n.t("tasks.general.events.cancel")
      )
      redirect_to(
        tasks_workflow_user_index_path(@task.story), notice: notice
      ) and return
    else
      render 'edit' and return
    end
  end

  def skip
    if @task.cancel
      redirect_to(
        next_task_workflow_user_index_path(@task.story)
      ) and return
    else
      render 'edit' and return
    end
  end
  
  def update
    if params[:event] && params[:event].keys.select{|k| ['cancel', 'skip'].include?(k)}.any?
      send(params[:event].keys.first)
      return
    end
    
    @task.attributes = params[:task]
    method = params[:event] ? params[:event].keys.first : 'save'
    success = false
    
    if @result.valid?
      success = if params[:next_step] == '1' || (params[:event] && params[:event][:next])
        @task.send(step) 
      elsif (method == 'save' && can?(:update, @task)) || can?(method.to_sym, @task)
        @task.send(method)
      else
        false
      end
    end
    
    render 'edit' and return unless success
        
    @result.save
    
    if params[:event] && params[:event][:next]
      redirect_to(
        next_task_workflow_user_index_path(@task.story), 
        notice: I18n.t('general.form.successfully_updated')
      ) and return
    end
    
    notice = if method == 'save'
      I18n.t('general.form.successfully_updated')
    else
      I18n.t(
        "general.notifications.event_successful", 
        event: I18n.t("tasks.general.events.#{method}")
      )
    end
    
    if can? :edit, @task
      redirect_to(
        edit_task_workflow_user_index_path(@task), notice: notice
      )
    else
      redirect_to(
        tasks_workflow_user_index_path(@task.story), notice: notice
      )
    end
  end
  
  def resource
    @task ||= Task.find(params[:id])
  end
  
  private
  
  def build_result
    result_params = params[:task] ? params[:task].delete(:result_attributes) : nil
    result_params = result_params || {}
    
    unless resource.result_id.present?
      @result = resource.result_class.new(result_params.merge(task_id: resource.id))
      @result.errors.clear
      return
    end
    
    if resource.result
      @result = resource.result
    elsif resource.result_id
      # WORKAROUND: do we still need this case?
      @result = resource.result_class.find(resource.result_id)
    end
    
    result_params.each {|param,value| @result.send("#{param}=", value) }
  end
end