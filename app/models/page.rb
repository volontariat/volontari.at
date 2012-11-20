class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::History::Trackable
  include Mongoid::Slug
  
  include StateMachines::Page
  
  field :user_id, type: Integer
  field :name, type: String
  field :text, type: String
  field :state, type: String
  
  index({ name: 1 }, { unique: true })
  
  attr_accessible :name, :text
  
  scope :active, where(state: 'active')
  
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :text, presence: true
  
  #track_history on: [:user_id, :name, :text, :state]
  slug :name
  
  # belongs_to (SQL)
  def user; user_id ? User.find(user_id) : nil; end
  def user=(value); self.user_id = value.id; end
end