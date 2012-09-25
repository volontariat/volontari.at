module ActiveModel
  module Naming
    private
    
    def self.model_name_from_record_or_class(record_or_class)
      return record_class if record_or_class.is_a?(Class)

      model_name = convert_to_model(record_or_class).class.model_name
      new_record_or_class = ApplicationHelper.root_model_class_name_helper(model_name.constantize.new).constantize.new
      
      convert_to_model(new_record_or_class).class.model_name
    end
  end
end