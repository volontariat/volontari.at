module ApplicationHelper
  include AutoHtml
  
  def self.root_model_class_name_helper(resource)
    if resource.class.superclass.name == 'ActiveRecord::Base'
      resource.class.name
    elsif resource.class.superclass.name == 'Object'
      # classes like mongo db models without a specific superclass
      resource.class.name
    else
      resource.class.superclass.name
    end
  end
  
  def markdown(text)
    text = Redcarpet::Markdown.new(Redcarpet::Render::XHTML.new(filter_html: true)).render(text)
    
    auto_html(text) do 
      youtube(width: 515, height: 300)
      dailymotion(width: 515, height: 300)
      vimeo(width: 515, height: 300)
      google_video(width: 515, height: 300)
      image

      redcarpet(
        renderer: Redcarpet::Render::XHTML.new(
          no_images: true, no_styles: true, hard_wrap: true, with_toc_data: true
        ),
        markdown_options: { no_intra_emphasis: true, autolink: true, fenced_code_blocks: true }
      )
      link :target => "_blank", :rel => "nofollow"
    end.gsub(/(>https?:\/\/[^\<\\]+)/) do |match| 
      truncate(match)
    end.html_safe
  end
  
  def root_model_class_name(resource)
    ::ApplicationHelper.root_model_class_name_helper(resource)
  end
  
  def directory_for_resource(resource)
    resource.class.name.split('::').last.underscore
  end
  
  def link_list(collection)
    raw collection.map{|a| link_to a.name, a}.join(', ')
  end
  
  def general_attribute?(attribute)
    begin
      t("activerecord.attributes.general.#{attribute}", raise: true)
      true
    rescue
      false
    end
  end
  
  def attribute_translation(attribute, current_resource = nil)
    current_resource = current_resource || resource
    
    t("activerecord.attributes.#{root_model_class_name(current_resource).underscore}.#{attribute}",
      default: t("activerecord.attributes.general.#{attribute}")
    )
  end
end
