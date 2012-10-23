class Resources::General::WizardPresenter < ResourcePresenter
  protected
  
  def self.steps(*step_list)
    step_list = step_list.first.is_a?(Symbol) ? step_list : step_list.first
    
    step_list.each do |step_name|  
      define_method step_name do |*args|
        options = args.first || {}
        
        product_specific_presenter(
          "#{self.class.name}::Steps::#{step_name.to_s.camelize}Presenter"
        )
      end
    end
  end
end