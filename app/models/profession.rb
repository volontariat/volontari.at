class Profession < ActiveRecord::Base
  include Applicat::Mvc::Model::Resource::Base
  
  has_many :users
  
  validates :name, presence: true, uniqueness: true
  
  attr_accessible :name
  
  extend FriendlyId
  
  friendly_id :name, :use => :slugged
end