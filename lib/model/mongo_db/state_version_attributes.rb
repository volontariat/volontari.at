module Model::MongoDb::StateVersionAttributes
  extend ActiveSupport::Concern 
  
  included do
    field :state_before, type: String
    field :event, type: String
    field :trigger, type: String
    field :trigger_object_type, type: String
    field :trigger_object_id, type: Integer
  end
end