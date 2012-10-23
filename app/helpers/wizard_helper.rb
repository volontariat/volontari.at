module WizardHelper
  def section_header(wizard_step)
    wizard_step_index = wizard_steps.index(wizard_step) + 1
    
    content = ["#{wizard_step_index} / #{wizard_steps.length}"] 
    content << t("stories.steps.#{wizard_step}.title")
    content << (future_step?(wizard_step) ? t('general.not_available') : '')
    
    content.join(' ')
  end
  
  def step_pane(wizard_step)
    return if future_step?(wizard_step)  
    
    partial_path = wizard_step == :initialization ? 'form' : "steps/#{wizard_step}"
    
    if @presenter.respond_to?(wizard_step)
      @step_presenter = @presenter.send(wizard_step) 
    else
      @step_presenter = nil
    end
    
    render_product_specific_partial_if_available(
      resource, "#{controller_name}/#{partial_path}"
    )
  end
end