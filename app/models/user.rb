class User < ActiveRecord::Base
  include ::Applicat::Mvc::Model::Resource::Base
  
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :areas
  has_and_belongs_to_many :projects
  
  has_many :offeror_vacancies, source: :offeror, class_name: 'Vacancy'
  has_many :offeror_candidatures, source: :offeror, class_name: 'Candidature'
  has_many :candidatures
  
  validates :name, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  #validates :language, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
        
  attr_accessible :name, :password, :password_confirmation, :text, :language, :first_name, :last_name, 
                  :salutation, :marital_status, :family_status, :date_of_birth, :place_of_birth, :citizenship, :email
       
  # :timeoutable, :token_authenticatable, :lockable,
  # :lock_strategy => :none, :unlock_strategy => :nones
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable 
  
  extend FriendlyId
  
  friendly_id :name, use: :slugged     
                  
  PARENT_TYPES = ['area', 'project']
end