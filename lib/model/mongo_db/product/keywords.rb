module Model::MongoDb::Product::Keywords
  extend ActiveSupport::Concern 
  
  included do
    field :with_keywords, type: Boolean
    field :min_number_of_keywords, type: Integer
    field :max_number_of_keywords, type: Integer
    
    attr_accessible :with_keywords, :min_number_of_keywords, :max_number_of_keywords
    
    validate :keyword_settings_present
  
    private
    
    def keyword_settings_present
      return unless self.with_keywords.present?
      
      [:min_number_of_keywords, :max_number_of_keywords].each do |attribute|
        if self.send(attribute).blank?
          errors[attribute] << I18n.t('activerecord.errors.messages.blank')
        end
      end
    end
  end
end