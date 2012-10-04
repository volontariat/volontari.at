class CandidaturesController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  
  load_and_authorize_resource
  
  before_filter :find_vacancy, only: [:index, :new, :edit]
  
  transition_actions Candidature::EVENTS
  
  helper_method :parent
  
  respond_to :html, :js, :json
  
  def index
    @candidatures = @vacancy ? @vacancy.candidatures.includes(:vacancy, :user) : Candidature.includes(:vacancy, :user).all
  end
  
  def show
    @candidature = Candidature.includes(:vacancy, :user, :comments).find(params[:id])
    @vacancy = @candidature.vacancy
    @comments = @candidature.comments
  end
  
  def new
    @candidature = Candidature.new
    @candidature.vacancy = parent
  end
  
  def create
    @candidature = Candidature.new(params[:candidature])
    @candidature.user_id = current_user.id
    
    if @candidature.save
      redirect_to @candidature, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
    @candidature = Candidature.find(params[:id])
  end
  
  def update
    @candidature = Candidature.find(params[:id])
    
    if @candidature.update_attributes(params[:candidature])
      redirect_to @candidature, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @candidature = Candidature.find(params[:id])
    @candidature.destroy
    redirect_to candidatures_url, notice: t('general.form.destroyed')
  end
  
  def resource
    @candidature
  end
  
  def parent
    @vacancy
  end
  
  protected
  
  def set_twitter_sidenav_level
    @twitter_sidenav_level = 5
  end
  
  private
  
  def find_vacancy
    @vacancy = params[:vacancy_id].present? ? Vacancy.find(params[:vacancy_id]) : nil
  end
end