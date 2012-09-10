class RailsInfo::Presenter
  def initialize(subject, options = {})
    @subject = subject
  end

  def subject=(value)
    @subject = value
  end 

  private
  
  def subject
    @subject
  end
  
  def method_missing(*args, &block)
    @subject.send(*args, &block)
  end
end