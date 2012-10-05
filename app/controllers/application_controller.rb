class ApplicationController < ActionController::Base
  include Applicat::Mvc::Controller
  
  protect_from_forgery
  
  before_filter :set_twitter_sidenav_level
  
  layout Proc.new { |controller| controller.request.xhr? ? 'facebox' : 'application' }
  
  rescue_from CanCan::AccessDenied, with: :access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found
  
  respond_to :html, :js, :json
  
  def parent
    nil
  end
  
  helper_method :parent
  
  protected
  
  def current_ability
    Ability.new(current_user, controller_namespace: current_namespace)
  end
  
  def set_twitter_sidenav_level
    @twitter_sidenav_level = 3
  end
  
  def find_parent(types, parent_key = nil)
    parent_type, id = nil, nil
    
    if parent_type = types.select{|p| params.keys.include?("#{p}_id") }.first
      id = params["#{parent_type}_id"]
    elsif parent_type = types.select{|p| params[parent_key] && params[parent_key].keys.include?("#{p}_id") }.first
      id = params[parent_key]["#{parent_type}_id"]
    end
    
    return if parent_type.blank?
    
    parent = parent_type.classify.constantize.find(id)
    root_model_class_name = ApplicationHelper.root_model_class_name_helper(parent)
    eval("@#{root_model_class_name.tableize.singularize} = parent") 
    
    parent
  end
  
  def response_with_standard(format = nil, error = nil)
    render status: error ? 500 : 200, json: { success: error ? false : true, error: error} and return true
  end
  
  private
  
  def current_namespace
    controller_name_segments = params[:controller].split('/')
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join('/').downcase
  end
  
  def access_denied
    message = I18n.t('general.exceptions.access_denied')
    
    if request.format.try('json?')
      render status: 403, json: { error: message } and return
    else
      flash[:alert] = message
      
      if request.env["HTTP_REFERER"]
        redirect_to :back
      else
        redirect_to root_path
      end
    end
  end
  
  def not_found(e)
    logger.info "not found (#{e.inspect})"
    redirect_to root_path, notice: t('general.exceptions.not_found')
  end
end
