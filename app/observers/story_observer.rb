class StoryObserver < ActiveRecord::Observer
  def before_transition(object, transition)
    object.event = transition.event.to_s
    object.state_before = transition.from
  end
end