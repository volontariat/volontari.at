class MongoDbDocument < ActiveRecord::Base
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :mongo_db_object_id, presence: true, uniqueness: { scope: :klass_name }
  validates :klass_name, presence: true
  validates :name, presence: true
  
  def mongo_db_object
    klass_name.constantize.find(mongo_db_object_id)
  end
end