class Result
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::History::Trackable
  
  include Model::MongoDb::Customizable
  include Model::MongoDb::Commentable
  
  #embedded_in :task
  belongs_to :task
  
  # cached associations
  belongs_to :story
  
  field :offeror_id, type: Integer
  field :user_id, type: Integer
  field :name, type: String
  field :text, type: String
  field :state, type: String
  
  attr_accessible :name, :text
  
  validates :task_id, presence: true
  validates :story_id, presence: true
  validates :offeror_id, presence: true
  validates :text, presence: true
  
  after_initialize :cache_associations
  before_validation :cache_associations

  #track_history on: [:name, :text, :state], scope: :task
  
  # belongs_to (SQL)
  def offeror; offeror_id ? User.find(offeror_id) : nil; end
  def offeror=(value); self.offeror_id = value.id; end
  
  def user; user_id ? User.find(user_id) : nil; end
  def user=(value); self.user_id = value.id; end
  
  private
  
  def cache_associations
    self.story_id = task.story_id if task_id.present?
    self.offeror_id = task.offeror_id if task_id.present?
  end
  
  def cache_product_association
    self.product_id = task.product_id if task_id.present?
  end
end