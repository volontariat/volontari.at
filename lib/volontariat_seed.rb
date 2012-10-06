class VolontariatSeed < DbSeed
  USER_ROLES = {
    master: {},
    admin: {},
    project_owner: {},
    user: {}
  }
  
  def create_fixtures
    super
    
    create_areas
    create_products
    
    # should send notifications to stream and email
  end
  
  private
  
  def create_areas
    Area.create!(
      [ 
        { name: 'General' },
        { name: 'Software Engineering' }
      ]
    )
  end
  
  def create_products
    product = Product.new(
      name: 'Text Creation', text: 'Dummy', area_ids: [Area.where(name: 'General').first.id]
    )
    product.user_id = User.where(name: 'Master').first.id
    product.save!
  end
end