class CandidatureObserver < ActiveRecord::Observer
  def after_create(candidature)
  end
  
  def before_transition(object, transition)
    #object.event = transition.event.to_s
    #object.from_state = transition.from
  end
 
  def after_transition(object, transition)
    #object.initiator_user = object.initiator_user
    #object.trigger = object.trigger
    #object.trigger_object = object.trigger_object
            
    case transition.to
      when 'accepted'
        ProjectUser.find_or_create_by_project_id_and_vacancy_id_and_user_id!(
          project_id: object.vacancy.project_id, vacancy_id: object.vacancy_id, 
          user_id: object.user_id
        )
        
        if object.vacancy.limit == object.vacancy.candidatures.accepted.count
          object.vacancy.close! unless object.vacancy.closed?
        end
      when 'denied'
        # if comming from :accepted then the vacancy offerer has to reopen the vacancy manually
    end
  end
end