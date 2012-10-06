module ShowHelper
  def show_attributes(*attributes)
    result = ''
    
    attributes.each {|attribute| result += show_attribute attribute}
    
    raw result
  end
  
  def show_attribute(attribute, options = {})
    title = options[:title] || attribute_translation(attribute)
    value = options[:value] || resource.send(attribute)
    
    value.blank? ? '' : content_tag(:dt, title) + content_tag(:dd, value)
  end
  
  def show_associations(*associations)
    result = ''
    
    associations.each {|association| result += show_association association}
    
    raw result
  end
  
  def show_association(association)
    if association.to_s == association.to_s.pluralize
      return show_attribute(
        association,
        title: t("#{association}.index.title"), 
        value: raw(resource.send(association).map{|a| link_to a.name, a}.join(', '))
      )
    end
    
    title = if general_attribute?(:parent)
      t("activerecord.attributes.general.#{association}")
    else
      if resource.send(association) 
        t("activerecord.models.#{root_model_class_name(resource.send(association)).underscore}")
      else 
        t("activerecord.models.#{association}")
      end
    end
    
    if resource.send(association)
      show_attribute(
        association,
        title: title, 
        value: link_to(resource.send(association).try(:name), resource.send(association))
      )  
    else
      ''
    end
  end
  
  def show_actions
    result  = content_tag :dt, raw('&nbsp')
    result += content_tag :dd, render(
      partial: 'shared/resource/actions', locals: { 
        type: root_model_class_name(resource).tableize, resource: resource 
      }
    )
     
    raw result
  end
end