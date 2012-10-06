module Model::MongoDb::Customizable
  extend ActiveSupport::Concern 
  
  included do
    # cache association as a shortcut
    belongs_to :product
    
    # for cases like f.object.send(association).klass.new in link_to_add_fields(name, f, association, options = {})
    after_initialize :cache_product_association
    
    before_validation :cache_product_association
    
    private
  
    def cache_product_association
      raise NotImplementedError
    end
  end
end