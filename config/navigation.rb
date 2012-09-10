SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |primary|
    primary.dom_class = 'nav'
    primary.item :root, t('general.index.title'), root_path
    
    primary.item :areas, t('areas.index.title'), areas_path do |areas|
      areas.item :new, t('general.new'), new_area_path
      
      if resource_exists?('area')
        areas.item :show, t('general.details'), area_path(@area) do |area|
          area.item :destroy, t('general.destroy'), area_path(@area), method: :delete, confirm: t('general.questions.are_you_sure')
          area.item :show_under, t('general.details'), area_path(@area)
          area.item :edit, t('general.edit'), edit_area_path(@area)
            
          area.item :users, t('users.index.title'), area_users_path(@area)
          area.item :projects, t('projects.index.title'), area_projects_path(@area)  
        end
      end
    end
    
    primary.item :projects, t('projects.index.title'), projects_path do |projects|
      projects.item :new, t('general.new'), new_project_path
      
      if @project.try(:id)
        projects.item :show, @project.name, project_path(@project) do |project|
          project.item :destroy, t('general.destroy'), project_path(@project), method: :delete, confirm: t('general.questions.are_you_sure')
          project.item :show, t('general.details'), project_path(@project)
          project.item :edit, t('general.edit'), edit_project_path(@project)
          
          project.item :users, t('users.index.title'), project_users_path(@project)  
          
          project.item :vacancies, t('vacancies.index.title'), project_vacancies_path(@project) do |vacancy|
            vacancy.item :new, t('general.new'), new_project_vacancy_path(@project)
          end
          
          project.item :comments, t('comments.index.title'), project_comments_path(@project) do |comments|
            comments.item(:new, t('general.new'), new_project_comment_path) if @comment
          end
        end
      end  
    end
    
    primary.item :vacancies, t('vacancies.index.title'), vacancies_path do |vacancies|
      vacancies.item :new, t('general.new'), new_vacancy_path
      
      if @vacancy.try(:id)
        vacancies.item :show, "#{@vacancy.name} @ #{@vacancy.project.name}", vacancy_path(@vacancy) do |vacancy|
          vacancy.item :destroy, t('general.destroy'), vacancy_path(@vacancy), method: :delete, confirm: t('general.questions.are_you_sure')
          vacancy.item :show, t('general.details'), vacancy_path(@vacancy)
          vacancy.item :edit, t('general.edit'), edit_vacancy_path(@vacancy)
            
          vacancy.item :candidatures, t('candidatures.index.title'), vacancy_candidatures_path(@vacancy) do |candidatures|
            candidatures.item :new, t('general.new'), new_vacancy_candidature_path(@vacancy)
            
            if resource_exists?('candidature')
              candidatures.item(
                :show, t('activerecord.models.candidature') + " of #{@candidature.user.name} @ #{@candidature.vacancy.project.name}", 
                candidature_path(@candidature) 
              ) do |candidature|
                candidature.item :destroy, t('general.destroy'), candidature_path(@candidature), method: :delete, confirm: t('general.questions.are_you_sure')
                candidature.item :show, t('general.details'), candidature_path(@candidature)
                candidature.item :edit, t('general.edit'), edit_candidature_path(@candidature)
                
                candidature.item :comments, t('comments.index.title'), candidature_comments_path(@candidature) do |comments|
                  comments.item(:new, t('general.new'), new_candidature_comment_path) if @comment
                end 
              end
            end
          end
           
          vacancy.item :comments, t('comments.index.title'), vacancy_comments_path(@vacancy) do |comments|
            comments.item(:new, t('general.new'), new_vacancy_comment_path) if @comment && !@candidature
          end 
        end
      end  
    end
    
    primary.item :users, t('users.index.title'), users_path do |users|
      if resource_exists?('user') && current_user.try(:id) != @user.id
        users.item :show, t('general.details'), user_path(@user)
        
        users.item :projects, t('projects.index.title'), user_projects_path(@user)
        users.item :candidatures, t('candidatures.index.title'), user_candidatures_path(@user)
      end
    end
 
    if user_signed_in?
      primary.item :workflow, t('workflow.index.title'), workflow_root_path do |workflow|
        workflow.item :vacancies, t('vacancies.index.title'), open_workflow_vacancies_path do |vacancies|
          Vacancy::STATES.each do |state|
            vacancies.item state, t("vacancies.show.states.#{state}"), eval("#{state}_workflow_vacancies_path")
          end
        end
          
        workflow.item :candidatures, t('candidatures.index.title'), new_workflow_candidatures_path do |candidatures|
          Candidature::STATES.each do |state|
            candidatures.item state, t("candidatures.show.states.#{state}"), eval("#{state}_workflow_candidatures_path")
          end
        end
      end
            
      primary.item :profile, t('users.show.title'), user_path(current_user) do |user|
        user.item :settings, t('users.edit.title'), edit_user_path(current_user)
        user.item :projects, t('projects.index.title'), user_projects_path(current_user)
        user.item :candidatures, t('candidatures.index.title'), user_candidatures_path(current_user)
      end
      
      primary.item :sign_out, t('authentication.sign_out'), destroy_user_session_path, method: :delete
    else
      primary.item :authentication, t('authentication.title'), new_user_session_path do |authentication|
        authentication.item :sign_in, t('authentication.sign_in'), new_user_session_path
        #authentication.item :rpx_sign_in, t('authentication.rpx_sign_in'), 'a' # link_to_rpx
        authentication.item :sign_up, t('authentication.sign_up'), new_user_registration_path
      end
    end
  end
end