class Comment < ActiveRecord::Base
  has_ancestry
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  
  validates :commentable_type, presence: true
  validates :commentable_id, presence: true
  validates :user_id, presence: true
  validates :name, presence: true
  validates :text, presence: true
  
  attr_accessible :commentable_type, :commentable_id, :parent_id, :name, :text
  
  COMMENTABLE_TYPES = ['project', 'vacancy', 'candidature']
end