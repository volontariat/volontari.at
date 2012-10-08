module LayoutHelper
  def breadcrumbs
    result = render_navigation context: :main, renderer: :breadcrumbs_without_method_links, join_with: ' &gt; '
    result && result.split('<a').length > 2 ? result : ''
  end
  
  def sidenav
    result = render_navigation context: :main, renderer: :twitter_sidenav, level: @twitter_sidenav_level
    result && result.split('<a').length > 2 ? result : ''
  end
  
  def footer_navigation
    links = []
    
    ['privacy_policy', 'terms_of_use', 'about_us'].each do |page_name|
      text = t("pages.#{page_name}.title")
      path = "#{controller_name}/#{action_name}"
      active = path == "#{controller_name}/#{page_name}" || (path == 'pages/index' && page_name == 'about_us')
      links << (active ? text : link_to(text, send("#{page_name}_pages_path")))
    end
    
    raw links.join(' | ')
  end
end