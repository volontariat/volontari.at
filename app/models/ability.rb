class Ability
  include CanCan::Ability

  def initialize(user, options = {})
    controller_namespace = options[:controller_namespace] || ""
    project = options[:project] || nil
    
    alias_action :index, :show, :new, :create, :edit, :update, :destroy, to: :restful_actions
    alias_action [], to: :admin_actions
    alias_action [], to: :moderation_actions
    alias_action :assign, :reject, :hold_on, to: :supervisor_actions
    
    alias_action :restful_actions, :admin_actions, to: :administrate
    alias_action :restful_actions, :moderation_actions, to: :moderate
    alias_action :read, :assign_actions, to: :supervisor
    
    can :read, [
      Area, Product, Project, Vacancy, Candidature, Story, Task, Result, Comment
    ]
    can [:read, :check_name, :check_url, :check_email, :check_email_unblocked], User
    
    if user.present?
      can :destroy, User, id: user.id
      
      can [:new, :create], [Area, Project, Vacancy, Candidature, Comment]
      
      { 
        user_id: [Product, Project, Candidature, Comment, ProjectUser, Result], 
        offeror_id: [Vacancy, Story, Task]
      }.each do |attribute, classes|
        can :restful_actions, classes, attribute => user.id   
      end
      
      can Candidature::EVENTS, Candidature, offeror_id: user.id
      can Vacancy::EVENTS, Vacancy, offeror_id: user.id
      
      if user.name == 'Master'
        can [:manage, :moderate, :administrate, :supervisor], :all
      end
    end
  end
end
