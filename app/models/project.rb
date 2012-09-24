class Project < ActiveRecord::Base
  belongs_to :user
  
  has_many :project_users
  has_many :vacancies, dependent: :destroy
  has_many :roles, through: :project_users
  has_many :comments, as: :commentable, dependent: :destroy
  
  has_and_belongs_to_many :users
  has_and_belongs_to_many :areas
  
  accepts_nested_attributes_for :areas, allow_destroy: true
  
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :text, presence: true
  validates :area_ids, presence: true
  
  attr_accessible :product_id, :name, :text, :url, :area_ids
  
  extend FriendlyId
  
  friendly_id :name, use: :slugged
  
  before_validation :include_areas_of_product
  
  PARENT_TYPES = ['area', 'user']
  
  # belongs_to (Mongo DB)
  def product
    product_id.blank? ? nil : Product.find(product_id)
  end
    
  # has_many (Mongo DB)
  def stories
    Story.where(project_id: id)
  end
  
  private
  
  def include_areas_of_product
    self.area_ids ||= []
    
    if product
      self.area_ids += product.areas.map(&:id)
      self.area_ids.uniq!
    end
  end
end