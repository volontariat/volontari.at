class UsersController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  
  respond_to :html, :js, :json
  
  def index
    parent = find_parent User::PARENT_TYPES
    @users = parent ? parent.users : User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: t('general.form.destroyed')
  end
  
  def resource
    @user
  end
end