class User < ActiveRecord::Base
  include ::Applicat::Mvc::Model::Resource::Base
  
  belongs_to :main_role, class_name: 'Role'
  belongs_to :profession
  
  has_and_belongs_to_many :roles, join_table: 'users_roles'
  has_and_belongs_to_many :areas
  has_and_belongs_to_many :projects
  
  has_many :offeror_vacancies, source: :offeror, class_name: 'Vacancy'
  has_many :offeror_candidatures, source: :offeror, class_name: 'Candidature'
  has_many :candidatures
  
  accepts_nested_attributes_for :areas, allow_destroy: true
  
  serialize :foreign_languages
  
  validates :name, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :language, presence: true
  validates :country, presence: true
  validates :interface_language, presence: true
        
  attr_accessible :name, :password, :password_confirmation, :text, :language, :first_name, :last_name, 
                  :salutation, :marital_status, :family_status, :date_of_birth, :place_of_birth, :citizenship, 
                  :email, :country, :language, :interface_language, :foreign_language_tokens, :profession_id, 
                  :employment_relationship, :area_tokens,
                  # preferences
                  :main_role_id
       
  # :timeoutable, :token_authenticatable, :lockable,
  # :lock_strategy => :none, :unlock_strategy => :nones
  devise :database_authenticatable, :registerable,# :confirmable,
         :recoverable, :rememberable, :trackable, :validatable 
  
  extend FriendlyId
  
  friendly_id :name, use: :slugged     
  
  after_create :set_main_role
                  
  PARENT_TYPES = ['area', 'project']
  
  def self.languages(query = nil)
    options = []
    
    AVAILABLE_LANGUAGES.merge(OTHER_LANGUAGES).each do |locale, language|
      next if query && !language.downcase.match(query.downcase)
      
      if query
        options << { id: locale, name: language }
      else
        options << [language, locale]
      end
    end
    
    options
  end
  
  def languages
    (foreign_languages || []) + [language]
  end
  
  def foreign_language_tokens=(tokens)
    self.foreign_languages = tokens.split(',')
  end
  
  def foreign_language_tokens
    options = []
    
    User.languages.each do |language|
      next unless (foreign_languages  || []).include?(language.second)
        
      options << { id: language.second, name: language.first } 
    end
    
    options
  end
  
  def area_tokens=(tokens)
    self.area_ids = Area.ids_from_tokens(tokens)
  end
  
  def area_tokens
    areas
  end
  
  private
  
  def set_main_role
    self.update_attribute :main_role_id, Role.find_or_create_by_name('User').id
  end
end