module Applicat::Mvc::Model::Tokenable
  extend ActiveSupport::Concern 
  
  included do
    
  end
  
  module ClassMethods
    def tokens(query)
      collection = where("name like ?", "%#{query}%")
      
      if collection.empty?
        [{id: "<<<#{query}>>>", name: "#{I18n.t('general.new')}: \"#{query}\""}]
      else
        collection
      end
    end
  
    def ids_from_tokens(tokens)
      tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
      tokens.split(',')
    end
  end
end