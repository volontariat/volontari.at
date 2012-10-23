class Product::TextCreation::Task < ::Task
  include StateMachines::Product::TextCreation::Task
  
  field :keywords, type: Array 
   
  attr_accessible :keywords
    
  validates :keywords, presence: true, unless: ->(t) { t.story.with_keywords.blank? }
  #validate :between_keyword_range
  
  #track_history on: [:user_id, :name, :text, :keywords, :state]
end