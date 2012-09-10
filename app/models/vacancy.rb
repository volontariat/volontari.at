class Vacancy < ActiveRecord::Base
  include StateMachines::Vacancy
  
  belongs_to :project
  belongs_to :offeror, class_name: 'User'
  belongs_to :user
  belongs_to :project_user
  
  has_many :candidatures
  has_many :comments, as: :commentable
  
  validates :project_id, presence: true
  validates :offeror_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :project_id }
  validates :text, presence: true
  
  attr_accessible :project_id, :name, :text, :limit
  
  extend FriendlyId
  
  friendly_id :name, use: :slugged
  
  before_validation :set_defaults
  
  private
  
  def set_defaults
    self.offeror_id = project.user_id unless self.offeror_id.present?
  end
end