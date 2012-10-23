class ProjectsController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  
  load_and_authorize_resource
  
  respond_to :html, :js, :json
  
  def index
    @parent = find_parent Project::PARENT_TYPES
    @projects = @parent ? @parent.projects.order(:name) : Project.order(:name)
  end
  
  def show
    @project = Project.includes(:areas, :comments).find(params[:id])
    @comments = @project.comments
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    @project.user_id = current_user.id
    
    if @project.save
      redirect_to @project, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    
    if @project.update_attributes(params[:project])
      redirect_to @project, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url, notice: t('general.form.destroyed')
  end
  
  def resource
    @project
  end
end