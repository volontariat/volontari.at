module ShowHelper
  def show_field(title, value)
    value.blank? ? '' : content_tag(:dt, title) + content_tag(:dd, value)
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