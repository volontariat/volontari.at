module CollectionHelper
  def table_cell column, resource, alternative_value = nil
    value = '-'
    
    if column == 'name'
      value = resource.send(column)
      
      if value.blank? && alternative_value.present? 
        value = eval("resource.#{alternative_value}")
      elsif value.blank?
        value = '-'
      end
      
      link_to value, eval("#{resource.class.name.tableize.singularize}_path(resource)")
    elsif column.match('_id')
      association = resource.send(column.gsub('_id', '')) rescue eval("resource.#{alternative_value}")
      link_to association.name, association
    else
      resource.send(column) 
    end
  end
end