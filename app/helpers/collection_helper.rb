module CollectionHelper
  def table_cell column, resource, alternative_value = nil
    value = '-'
    
    if column == 'name'
      value = resource.send(column)
      
      if alternative_value.is_a?(Proc)
        return alternative_value.call(resource)
      elsif value.blank? && alternative_value.present? 
        value = eval("resource.#{alternative_value}")
      elsif value.blank?
        value = '-'
      end
      
      link_to value, eval("#{root_model_class_name(resource).tableize.singularize}_path(resource)")
    elsif column.match('_id')
      association = nil
      
      begin
        association = resource.send(column.gsub('_id', '')) 
      rescue 
        association = eval("resource.#{alternative_value}") if alternative_value.present?
      end
      
      association ? link_to(association.name, association) : value
    else
      resource.send(column) 
    end
  end
end