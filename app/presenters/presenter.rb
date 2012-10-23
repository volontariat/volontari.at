class Presenter
  def initialize(subject, options = {})
    @subject = subject
    set_default_options(options)
  end

  def subject=(value)
    @subject = value
  end 
  
  def set_options(options)
    raise NotImplementedError
  end

  def set_option(option, value)
    @options[option] = value
  end

  protected
  
  def set_default_options(options)
    @options ||= {}
   
    options.each do |key,value|
      @options[key] = value unless @options.has_key?(key)
    end
  end
  
  def subject
    @subject
  end
  
  def subject=(value)
    @subject = value
  end
  
  private
  
  def method_missing(*args, &block)
    if args.is_a?(Array) && @options.has_key?(args.first)
      @options[args.first] 
    else
      @subject.send(*args, &block)
    end
  end
end