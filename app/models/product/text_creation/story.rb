class Product::TextCreation::Story < Story
  include Model::MongoDb::Product::Keywords
  
  has_many :tasks, dependent: :destroy, class_name: 'Product::TextCreation::Task', inverse_of: :story
  
  field :language, type: String
  field :min_length, type: Integer
  field :max_length, type: Integer
  field :with_quality_assurance, type: Boolean
   
  attr_accessible :language, :min_length, :max_length, :with_quality_assurance
   
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: ->(t) { t['name'].blank? }
   
  validates :language, presence: true
  validates :min_length, presence: true
  validates :max_length, presence: true
  
  def self.for_user(user)
    active.where(:language.in => user.languages)
  end
end