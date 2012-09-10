class Area < ActiveRecord::Base
  include Applicat::Mvc::Model::Resource::Base
  include Applicat::Mvc::Model::Tree
  
  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects
  
  validates :name, presence: true, uniqueness: true
  
  attr_accessible :name
  
  extend FriendlyId
  
  friendly_id :name, :use => :slugged
end