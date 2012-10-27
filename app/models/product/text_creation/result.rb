class Product::TextCreation::Result < ::Result
  validate :text_length_between_range
  
  private
  
  def text_length_between_range
    unless text && (text.strip.length >= task.story.min_length && text.strip.length <= task.story.max_length)
      errors[:text] << I18n.t(
        'activerecord.errors.models.result.attributes.text.text_length_not_between_range',
        min_length: task.story.min_length, max_length: task.story.max_length
      )
    end
  end
end