class PagesController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  
  load_and_authorize_resource
  
  respond_to :html, :js, :json
  
  def index
    @pages = Page.order_by(name: 'ASC')
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    @page.user = current_user
    
    if @page.save
      redirect_to @page, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    
    if @page.update_attributes(params[:page])
      redirect_to @page, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to pages_url, notice: t('general.form.destroyed')
  end
  
  def resource
    @page
  end
end