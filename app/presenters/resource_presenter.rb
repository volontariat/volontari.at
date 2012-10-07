class ResourcePresenter < Presenter
  def initialize(subject, options = {})
    @resource = options.delete(:resource)
    
    super(subject, options)
  end
  
  protected
  
  def resource
    @resource
  end
  
  def product
    if @resource && @resource.respond_to?(:product)
      @resource.product
    else
      nil
    end
  end
  
  def product_specific_presenter(klass_name)
    klass_name = klass_name.split('::')
    last_part = klass_name.pop
    klass_name = klass_name.map{|part| part.gsub('Presenter', '')}.join('::')
    klass = "#{product.class.name}::#{klass_name}::#{last_part}".constantize rescue nil if product

    (klass ? klass : "#{klass_name}::#{last_part}".constantize).new(subject, resource: @resource)
  end
end