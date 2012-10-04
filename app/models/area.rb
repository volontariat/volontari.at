class Area < ActiveRecord::Base
  include Applicat::Mvc::Model::Resource::Base
  include Applicat::Mvc::Model::Tree
  
  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects
  
  validates :name, presence: true, uniqueness: true
  
  attr_accessible :name
  
  extend FriendlyId
  
  friendly_id :name, :use => :slugged
  
  def products
  end
  
  def self.tokens(query)
    collection = where("name like ?", "%#{query}%")
    
    if collection.empty?
      [{id: "<<<#{query}>>>", name: "#{I18n.t('general.new')}: \"#{query}\""}]
    else
      collection
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end
end