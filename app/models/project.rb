class Project < ActiveRecord::Base
  belongs_to :user
  
  has_many :project_users
  has_many :vacancies
  has_many :roles, through: :project_users
  has_many :comments, as: :commentable
  
  has_and_belongs_to_many :users
  has_and_belongs_to_many :areas
  
  accepts_nested_attributes_for :areas, allow_destroy: true
  
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :text, presence: true
  
  attr_accessible :name, :text, :url, :area_ids
  
  extend FriendlyId
  
  friendly_id :name, :use => :slugged
  
  PARENT_TYPES = ['area', 'user']
end