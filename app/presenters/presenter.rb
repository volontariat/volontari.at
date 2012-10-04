class Presenter
  def initialize(subject, options = {})
    @subject = subject
  end

  def subject=(value)
    @subject = value
  end 

  protected
  
  def subject
    @subject
  end
  
  private
  
  def method_missing(*args, &block)
    @subject.send(*args, &block)
  end
end