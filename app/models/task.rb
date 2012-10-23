class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  #include Mongoid::History::Trackable
  
  include Model::MongoDb::Customizable
  include Model::MongoDb::Commentable
  include StateMachines::Task
  
  #embedded_in :story
  belongs_to :story
  
  #embeds_one :result
  has_one :result, dependent: :destroy
  
  accepts_nested_attributes_for :result, allow_destroy: true
  
  field :offeror_id, type: Integer
  field :user_id, type: Integer
  field :author_id, type: Integer
  field :name, type: String
  field :text, type: String
  field :state, type: String
  field :unassigned_user_ids, type: Array
  
  slug :name
   
  attr_accessible :story_id, :name, :text, :result_attributes
  
  scope :current, where(state: 'new')
  scope :unassigned, where(user_id: nil)
  scope :assigned, ne(user_id: nil)
  scope :complete, where(state: 'completed')
  scope :incomplete, ne(state: 'completed')
  
  validates :story_id, presence: true
  validates :offeror_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :story_id }
  validates :text, presence: true, if: ->(t) { t.class.name == 'Task' }
  validate :reserved_words_exclusion
  
  after_initialize :cache_associations
  before_validation :cache_associations  
    
  #track_history on: [:user_id, :name, :text, :state]
    
  PARENT_TYPES = ['story']

  # belongs_to (SQL)
  def offeror; offeror_id ? User.find(offeror_id) : nil; end
  def offeror=(value); self.offeror_id = value.id; end
  
  def user; user_id ? User.find(user_id) : nil; end
  def user=(value); self.user_id = value.id; end
  
  def author; author_id ? User.find(author_id) : nil; end
  def author=(value); self.author_id = value.id; end
  
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