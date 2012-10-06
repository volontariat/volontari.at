class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  include Model::MongoDb::Customizable
  include StateMachines::Story
  include Model::MongoDb::Commentable
  
  has_many :tasks, dependent: :destroy#, inverse_of: :story
  
  # cached associations
  has_many :results
  
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: ->(t) { t['name'].blank? && t['text'].blank? }
  
  field :project_id, type: Integer
  field :offeror_id, type: Integer
  field :name, type: String
  field :text, type: String
  field :state, type: String
  
  slug :name
  
  attr_accessible :project_id, :name, :text, :tasks_attributes
  
  validates :project_id, presence: true
  validates :offeror_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :project_id }
  validates :text, presence: true
  
  after_initialize :cache_associations
  before_validation :cache_associations 

  PARENT_TYPES = ['project']
  
  # belongs_to (SQL)
  def offeror; offeror_id ? User.find(offeror_id) : nil; end
  def offeror=(value); self.offeror_id = value.id; end
  
  def project; project_id ? Project.find(project_id) : nil; end
  def project=(value); self.project_id = value.id; end
  
  private
  
  def cache_associations
    self.offeror_id = project.user_id if project_id.present?
  end
  
  def cache_product_association
    self.product_id = project.product_id if project_id.present?
  end
end