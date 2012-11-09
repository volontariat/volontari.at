class DeviseExtensions::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    resource = build_resource({})
    
    @presenter = Resources::User::FormPresenter.new(self.view_context, resource: resource)  
    
    respond_with resource
  end
  
  # POST /resource
  def create
    build_resource

    captcha_verified = if Rails.env == 'production'
      verify_recaptcha(model: resource, message: I18n.t('general.exceptions.wrong_recaptcha'))
    else
      true
    end
    
    if captcha_verified && resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      @presenter = Resources::User::FormPresenter.new(self.view_context, resource: resource)  
      clean_up_passwords resource
      respond_with resource
    end
  end
end
