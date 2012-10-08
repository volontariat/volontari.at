class TasksController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  include Wizard::Controller
  
  wizard_steps :setup_tasks, :activate
  
  before_filter :build_resource, only: [:new, :create]
  before_filter :resource, only: [:show, :edit, :update, :setup_tasks, :activate]
  
  load_and_authorize_resource
  
  respond_to :html, :js, :json
  
  def index
    parent = find_parent Task::PARENT_TYPES
    @tasks = parent ? parent.tasks : Task.all
  end
  
  def show
    @comments = @task.comments
  end
  
  def new
    render_wizard
  end
  
  def create
    if @task.initialization
      redirect_to edit_task_path(@task) and return
    else
      render_wizard
    end
  end
  
  def edit
    render_wizard
  end
  
  def update
    @task.attributes = params[:task]
    
    # shift the first empty task set after initialization on state :initialized
    @task.tasks.shift if params[:next_step] == '1' && !@task.tasks.first.valid?
    success = params[:next_step] == '1' ? @task.send(step) : @task.save
      
    if success
      redirect_to(
        edit_task_path(@task), notice: t('general.form.successfully_updated')
      )
    else
      render_wizard
    end
    
    return
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to @task.story, notice: t('general.form.destroyed')
  end
  
  def resource
    @task = Task.find(params[:id]) unless @task || !params[:id].present?
    @story = @task.story unless @story || !@task
    @task
  end
  
  def resource=(value); @task = value; end
  
  def parent
    @story
  end
  
  private
  
  def build_resource
    @story = find_parent Task::PARENT_TYPES, action_name == 'create' ? :task : nil
    @task = @story.tasks.new({ story_id: @story.id }.merge(params[:task] || {}))
  end
  
  def render_wizard
    @presenter = Resources::General::Wizards::TaskPresenter.new(
      self.view_context, resource: resource
    )
    render 'general/wizard'
  end
end