class TaskObserver < ActiveRecord::Observer
  def before_transition(object, transition)
    object.event = transition.event.to_s
    object.state_before = transition.from
    
    case transition.event
    when :assign
      object.author_id = object.user_id
    when :cancel
      object.unassigned_user_ids ||= []
      object.unassigned_user_ids << object.user_id
      object.user_id = nil
      object.author_id = nil
      object.result.text = nil if object.result
    when :review
      object.user_id = object.offeror_id
    when :follow_up
      object.user_id = object.author_id
    end
  end
  
  def after_transition(object, transition)
    case transition.event
    when :follow_up
      if object.story.completed?
        object.story.activate
      end
    when :complete
      if object.story.tasks.complete.count == object.story.tasks.count
        object.story.complete
      end
    end
  end
end