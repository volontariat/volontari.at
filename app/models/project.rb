class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  
  has_many :project_users, dependent: :destroy
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
  
  attr_accessible :organization_id, :product_id, :name, :text, :url, :area_ids
  
  extend FriendlyId
  
  before_validation :include_areas_of_product
  after_create :create_project_user
  after_destroy :destroy_non_active_records
  
  friendly_id :name, use: :slugged
  
  PARENT_TYPES = ['area', 'product', 'user']
  
  # belongs_to (Mongo DB)
  def product
    return @product if @product
    
    @product = product_id.blank? ? nil : Product.find(product_id)
  end
  
  def product=(document)
    @product = document
    self.product_id = @product.try(:id)
  end
    
  # has_many (Mongo DB)
  def story_class
    if product_id.present?
      "#{product.class.name}::Story".constantize rescue Story
    else
      Story
    end
  end
   
  def stories; story_class.where(project_id: id); end
  
  private
  
  def include_areas_of_product
    self.area_ids ||= []
    
    if product
      self.area_ids += product.areas.map(&:id)
      self.area_ids.uniq!
    end
  end
  
  def create_project_user
    ProjectUser.create(project_id: id, user_id: user_id)
  end
  
  def destroy_non_active_records
    stories.all.map(&:destroy)
  end
end