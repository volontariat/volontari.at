class VolontariatSeed < DbSeed
  USER_ROLES = {
    master: {},
    admin: {},
    moderator: {},
    supervisor: {},
    user: {}
  }
  
  def create_fixtures
    super
    
    create_areas

    # should send notifications to stream and email
  end
  
  private
  
  def create_areas
    Area.import(
      [:name], 
      [
        ['Software Engineering'], 
      ]
    )
  end
end