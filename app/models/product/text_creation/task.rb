class Product::TextCreation::Task < ::Task
  field :keywords, type: Array 
   
  attr_accessible :keywords
    
  validates :text, presence: false
  validates :keywords, presence: true, unless: ->(t) { t.story.with_keywords.blank? }
  #validate :between_keyword_range

  # WORKRAROUND: overriding text validation doesn't work
  before_validation :add_text
  after_validation :remove_text
  
  private
  
  def add_text
    self.text = 'Dummy'
  end
  
  def remove_text
    self.text = nil
  end
end