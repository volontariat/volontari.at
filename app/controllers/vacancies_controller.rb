class VacanciesController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  
  load_and_authorize_resource
  
  before_filter :find_project, only: [:index, :new, :edit]
  
  respond_to :html, :js, :json
  
  def index
    @vacancies = @project ? @project.vacancies : Vacancy.all
  end
  
  def show
    @vacancy = Vacancy.includes(:project, :candidatures, :comments).find(params[:id])
    @comments = @vacancy.comments
  end
  
  def new
    @vacancy = Vacancy.new
    
    @vacancy.project = @project if @project
  end
  
  def create
    @vacancy = Vacancy.new(params[:vacancy])
    
    if @vacancy.project.user_id == current_user.id
      @vacancy.do_open
    else
      @vacancy.author_id = current_user.id 
      @vacancy.recommend
    end
    
    if @vacancy.save
      redirect_to @vacancy, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
    @vacancy = Vacancy.find(params[:id])
  end
  
  def update
    @vacancy = Vacancy.find(params[:id])
    
    if @vacancy.update_attributes(params[:vacancy])
      redirect_to @vacancy, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @vacancy = Vacancy.find(params[:id])
    @vacancy.destroy
    redirect_to vacancies_url, notice: t('general.form.destroyed')
  end
  
  def resource
    @vacancy
  end
  
  transition_actions Vacancy::EVENTS
  
  protected
  
  def before_my_state
    # e.g. set attributes of resource
  end
  
  private
  
  def find_project
    @project = params[:project_id].present? ? Project.find(params[:project_id]) : nil
  end
end