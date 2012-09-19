class Vacancy < ActiveRecord::Base
  include StateMachines::Vacancy
  
  belongs_to :project
  belongs_to :offeror, class_name: 'User'
  belongs_to :author, class_name: 'User'
  belongs_to :user
  belongs_to :project_user
  
  has_many :candidatures, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  
  scope :open, where(state: 'open')
  
  validates :project_id, presence: true
  validates :offeror_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :project_id }
  validates :text, presence: true
  validates :limit, presence: true
  
  attr_accessible :project_id, :name, :text, :limit
  
  extend FriendlyId
  
  friendly_id :name, use: :slugged
  
  before_validation :set_defaults
  
  def candidatures_left
    limit - candidatures.accepted.count
  end
  
  private
  
  def set_defaults
    if project
      self.offeror_id = project.user_id
      self.author_id = project.user_id unless self.author_id.present?
    end
  end
end