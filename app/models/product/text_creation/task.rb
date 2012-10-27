class Product::TextCreation::Task < ::Task
  belongs_to :result, dependent: :destroy, class_name: 'Product::TextCreation::Result', inverse_of: :task
  
  field :keywords, type: Array 
   
  attr_accessible :keywords
    
  validates :keywords, presence: true, unless: ->(t) { t.story.with_keywords.blank? }
  #validate :between_keyword_range
  
  #track_history on: [:user_id, :name, :text, :keywords, :state]
end