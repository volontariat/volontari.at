class Resources::User::FormPresenter < ResourcePresenter
  def attributes
    list = [
      :name, :first_name, :last_name, :email, 
    ]
    
    list += [:password, :password_confirmation] if resource.new_record?
    
    list += [
      :country, :language, :interface_language, :foreign_language_tokens, :profession, 
      :employment_relationship, :area_tokens
    ]
    
    list
  end
end