class ProfessionsController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  respond_to :html, :js, :json
  
  def index
    @professions = Profession.order(:name)
      
    respond_to do |format|
      format.html
      format.json { render json: @professions.tokens(params[:q]) }
    end
  end
  
  def show
    @profession = Profession.find(params[:id])
  end
  
  def new
    @profession = Profession.new
  end
  
  def create
    @profession = Profession.new(params[:profession])
    
    if @profession.save
      redirect_to @profession, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
    @profession = Profession.find(params[:id])
  end
  
  def update
    @profession = Profession.find(params[:id])
    
    if @profession.update_attributes(params[:profession])
      redirect_to @profession, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @profession = Profession.find(params[:id])
    @profession.destroy
    redirect_to professions_url, notice: t('general.form.destroyed')
  end
  
  def resource
    @profession
  end
  
  private
  
  def not_found
    redirect_to professions_path, notice: t('professions.exceptions.not_found')
  end
end