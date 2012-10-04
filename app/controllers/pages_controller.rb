class PagesController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  
  def index
    render 'about_us'  
  end
  
  def privacy_policy
  end
  
  def terms_of_use
  end
  
  def about_us
  end
end