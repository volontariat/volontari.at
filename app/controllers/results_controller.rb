class ResultsController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  include Wizard::Controller
  
  wizard_steps :setup_results, :activate
  
  before_filter :build_resource, only: [:new, :create]
  before_filter :resource, only: [:show, :edit, :update, :setup_results, :activate]
  
  load_and_authorize_resource
  
  respond_to :html, :js, :json
  
  def index
    parent = find_parent Result::PARENT_TYPES
    @results = parent ? parent.results : Result.all
  end
  
  def show
    @comments = @result.comments
  end
  
  def new
    render_wizard
  end
  
  def create
    if @result.initialization
      redirect_to edit_result_path(@result) and return
    else
      render_wizard
    end
  end
  
  def edit
    if @result.results.none?
      @result.results << @result.result_class.new
      @result.results.first.errors.clear
    end
    
    render_wizard
  end
  
  def update
    @result.attributes = params[:result]
    
    # shift the first empty result set after initialization on state :initialized
    @result.results.shift if params[:next_step] == '1' && !@result.results.first.valid?
    success = params[:next_step] == '1' ? @result.send(step) : @result.save
      
    if success
      redirect_to(
        edit_result_path(@result), notice: t('general.form.successfully_updated')
      )
    else
      render_wizard
    end
    
    return
  end

  def destroy
    @result = Result.find(params[:id])
    @result.destroy
    redirect_to @result.task, notice: t('general.form.destroyed')
  end
  
  def resource
    @result = Result.find(params[:id]) unless @result || !params[:id].present?
    @task = @result.task unless @task || !@result
    @result
  end
  
  def resource=(value); @result = value; end
  
  def parent
    @task
  end
  
  private
  
  def build_resource
    @task = find_parent Result::PARENT_TYPES, action_name == 'create' ? :result : nil
    @result = @task.result_class.new({ task_id: @task.id }.merge(params[:result] || {}))
  end
  
  def render_wizard
    @presenter = Resources::General::Wizards::ResultPresenter.new(
      self.view_context, resource: resource
    )
    render 'general/wizard'
  end
end