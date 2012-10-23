class OrganizationsController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  respond_to :html, :js, :json
  
  def index
    @parent = find_parent Organization::PARENT_TYPES
    @organizations = @parent ? @parent.organizations.order(:name) : Organization.order(:name)
    
    respond_to do |format|
      format.html
      format.json { render json: @organizations.tokens(params[:q]) }
    end
  end
  
  def show
    @organization = Organization.find(params[:id])
  end
  
  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.new(params[:organization])
    
    if @organization.save
      redirect_to @organization, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
    @organization = Organization.find(params[:id])
  end
  
  def update
    @organization = Organization.find(params[:id])
    
    if @organization.update_attributes(params[:organization])
      redirect_to @organization, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to organizations_url, notice: t('general.form.destroyed')
  end
  
  def resource
    @organization
  end
  
  private
  
  def not_found
    redirect_to organizations_path, notice: t('organizations.exceptions.not_found')
  end
end