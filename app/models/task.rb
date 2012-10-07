class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  include Model::MongoDb::Customizable
  include Model::MongoDb::Commentable
  
  #embedded_in :story
  belongs_to :story
  
  #embeds_one :result
  has_one :result, dependent: :destroy
  
  accepts_nested_attributes_for :result, allow_destroy: true
  
  field :offeror_id, type: Integer
  field :user_id, type: Integer
  field :name, type: String
  field :text, type: String
  field :state, type: String
  
  slug :name
  
  attr_accessible :story_id, :name, :text, :result_attributes
  
  validates :story_id, presence: true
  validates :offeror_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :story_id }
  validates :text, presence: true
  validate :reserved_words_exclusion
  
  after_initialize :cache_associations
  before_validation :cache_associations  
    
  PARENT_TYPES = ['story']

  # belongs_to (SQL)
  def offeror; offeror_id ? User.find(offeror_id) : nil; end
  def offeror=(value); self.offeror_id = value.id; end
  
  def user; user_id ? User.find(user_id) : nil; end
  def user=(value); self.user_id = value.id; end
  
  private
  
  def reserved_words_exclusion
    current_slug = to_param
    
    if ['new', 'edit', 'next'].include?(current_slug)
      message = I18n.t(
        'activerecord.errors.models.general.attributes.name.reserved_word_included'
      )
      errors[:name] << message unless errors[:name].include? message
    end
  end
  
  def cache_associations
    self.offeror_id = story.offeror_id if story.present?
  end
  
  def cache_product_association
    self.product_id = story.product_id if story.present?
  end
end