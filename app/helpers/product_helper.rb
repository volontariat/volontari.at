module ProductHelper
  def render_product_specific_presenter_if_available(resource, partial_path, method, options = {})
    if @presenter.respond_to?(method)
      @step_presenter = @presenter.send(method) 
    else
      @step_presenter = nil
    end
    
    render_product_specific_partial_if_available(resource, "#{partial_path}/#{method}", options)
  end
  
  def render_product_specific_partial_if_available(resource, partial_path, options = {})
    path = nil
    partial_path = partial_path.split('/')
    file_name = partial_path.pop
    partial_path = partial_path.join('/')
    
    if resource && resource.respond_to?(:product) && resource.product
      path = "products/types/#{directory_for_resource(resource.product)}/#{partial_path}"
      
      if File.exist?("#{Rails.root.to_s}/app/views/#{path}/_#{file_name}.html.erb")
        path = [path, file_name].join('/')
      else
        path = nil
      end
    end

    path = [partial_path, file_name].join('/') if path.blank?

    render path, options 
  end
end