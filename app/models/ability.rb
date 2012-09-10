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
    
    can :read, Area
    can :read, Project
    can :read, Vacancy
    can :read, Candidature
    can :read, Comment
    can [:read, :check_name, :check_url, :check_email, :check_email_unblocked], User
    
    if user.present?
      can :destroy, User, id: user.id
      
      can [:new, :create], Area
      can [:new, :create], Project
      can [:new, :create], Vacancy
      can [:new, :create], Candidature
      can [:new, :create], Comment
      #can :create, [Like, Dislike]
      
      can :restful_actions, Project, user_id: user.id
      can :restful_actions, Vacancy, offeror_id: user.id
      can :restful_actions, Candidature, user_id: user.id
      can :restful_actions, Comment, user_id: user.id
      #can :restful_actions, [Like, Dislike], user_id: user.id
      can :restful_actions, ProjectUser, user_id: user.id
      
      can Candidature::EVENTS, Candidature, offeror_id: user.id
      can Vacancy::EVENTS, Vacancy, offeror_id: user.id
      
      #can :administrate, Area if user.roles.where('name = "Administrator"').any?

      #can :moderate, Project, project_users: {user_id: user.id, role_id: Role.find('Administrator')}

      #if user.master?
      #  can [:manage, :moderate, :administrate, :supervisor], :all
      #end
      
      if user.id == 1
        can [:manage, :moderate, :administrate, :supervisor], :all
      end
    end

    if controller_namespace.starts_with?('admin')
      cannot :manage, :all # unless
    end
  end
end
