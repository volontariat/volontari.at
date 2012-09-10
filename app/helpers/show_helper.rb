module ShowHelper
  def show_field(title, value)
    value.blank? ? '' : content_tag(:dt, title) + content_tag(:dd, value)
  end
end