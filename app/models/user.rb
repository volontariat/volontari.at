class User < ActiveRecord::Base
  include ::Applicat::Mvc::Model::Resource::Base
  
  belongs_to :profession
  
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :areas
  has_and_belongs_to_many :projects
  
  has_many :offeror_vacancies, source: :offeror, class_name: 'Vacancy'
  has_many :offeror_candidatures, source: :offeror, class_name: 'Candidature'
  has_many :candidatures
  
  accepts_nested_attributes_for :areas, allow_destroy: true
  
  validates :name, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :language, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :country, presence: true
  validates :interface_language, presence: true
        
  attr_accessible :name, :password, :password_confirmation, :text, :language, :first_name, :last_name, 
                  :salutation, :marital_status, :family_status, :date_of_birth, :place_of_birth, :citizenship, :email,
                  :country, :language, :interface_language, :profession_id, :employment_relationship, 
                  :area_tokens
       
  # :timeoutable, :token_authenticatable, :lockable,
  # :lock_strategy => :none, :unlock_strategy => :nones
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable 
  
  extend FriendlyId
  
  friendly_id :name, use: :slugged     
                  
  PARENT_TYPES = ['area', 'project']
  
  def area_tokens=(tokens)
    self.area_ids = Area.ids_from_tokens(tokens)
  end
  
  def area_tokens
    areas
  end
end