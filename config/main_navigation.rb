SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |primary|
    primary.dom_class = 'nav'
    primary.item :root, t('general.index.title'), root_path
    
    primary.item :areas, t('areas.index.title'), areas_path do |areas|
      areas.item :new, t('general.new'), new_area_path
      
      unless (@area.new_record? rescue true)
        areas.item :show, @area.name, area_path(@area) do |area|
          if can? :destroy, @area
            area.item :destroy, t('general.destroy'), area_path(@area), method: :delete, confirm: t('general.questions.are_you_sure')
          end
          
          area.item :show, t('general.details'), "#{area_path(@area)}#top"
          area.item :edit, t('general.edit'), edit_area_path(@area) if can? :edit, @area
          area.item :users, t('users.index.title'), area_users_path(@area)
          area.item :projects, t('projects.index.title'), area_projects_path(@area)  
        end
      end
    end
    
    primary.item :products, t('products.index.title'), products_path do |products|
      products.item :new, t('general.new'), new_product_path
      
      unless (@product.new_record? rescue true)
        products.item :show, @product.name, product_path(@product) do |product|
          if can? :edit, @product
            product.item :destroy, t('general.destroy'), product_path(@product), method: :delete, confirm: t('general.questions.are_you_sure')
          end
          
          product.item :show, t('general.details'), "#{product_path(@product)}#top"
          product.item :edit, t('general.edit'), edit_product_path(@product)  if can? :edit, @product
            
          product.item :projects, t('projects.index.title'), product_projects_path(@product)  
        end
      end
    end
    
    primary.item :projects, t('projects.index.title'), projects_path do |projects|
      projects.item :new, t('general.new'), new_project_path
      
      unless (@project.new_record? rescue true)
        projects.item :show, @project.name, project_path(@project) do |project|
          if can? :destroy, @project
            project.item :destroy, t('general.destroy'), project_path(@project), method: :delete, confirm: t('general.questions.are_you_sure')
          end
          
          project.item :show, t('general.details'), "#{project_path(@project)}#top"
          project.item :edit, t('general.edit'), edit_project_path(@project) if can? :edit, @project
          
          project.item :users, t('users.index.title'), project_users_path(@project)  
          
          project.item :vacancies, t('vacancies.index.title'), project_vacancies_path(@project) do |vacancy|
            vacancy.item :new, t('general.new'), new_project_vacancy_path(@project)
          end
          
          project.item :stories, t('stories.index.title'), project_stories_path(@project) do |stories|
            stories.item :new, t('general.new'), new_project_story_path(@project)

            unless (@story.new_record? rescue true)
              stories.item(:show, @story.name, story_path(@story)) do |story|
                if can? :destroy, @story
                  story.item :destroy, t('general.destroy'), story_path(@story), method: :delete, confirm: t('general.questions.are_you_sure')
                end
                
                story.item :show, t('general.details'), "#{story_path(@story)}#top"
                story.item :edit, t('general.edit'), edit_story_path(@story) if can? :edit, @story

                story.item :steps, t('general.steps'), setup_tasks_story_path(@story) do |steps|
                  steps.item :setup_tasks, t('stories.steps.setup_tasks.title'), setup_tasks_story_path(@story)
                  steps.item :activate, t('general.events.activate'), activate_story_path(@story)
                end
                                
                story.item :tasks, t('tasks.index.title'), story_tasks_path(@story) do |tasks|
                  tasks.item :new, t('general.new'), new_story_task_path(@story)
      
                  unless (@task.new_record? rescue true)
                    tasks.item(:show, @task.name, task_path(@task)) do |task|
                      if can? :destroy, @task
                        task.item :destroy, t('general.destroy'), task_path(@task), method: :delete, confirm: t('general.questions.are_you_sure')
                      end
                      
                      task.item :show, t('general.details'), "#{task_path(@task)}#top"
                      task.item :edit, t('general.edit'), edit_task_path(@task) if can? :edit, @task
                      
                      task.item :results, t('results.index.title'), task_results_path(@task) do |results|
                        results.item :new, t('general.new'), new_task_result_path(@task)
            
                        unless (@result.new_record? rescue true)
                          results.item(:show, @result.name, result_path(@result)) do |result|
                            if can? :destroy, @result
                              result.item :destroy, t('general.destroy'), result_path(@result), method: :delete, confirm: t('general.questions.are_you_sure')
                            end
                            
                            result.item :show, t('general.details'), "#{result_path(@result)}#top"
                            result.item :edit, t('general.edit'), edit_result_path(@result) if can? :edit, @result
                            
                            result.item :comments, t('comments.index.title'), "#{story_path(@story)}#comments" do |comments|
                              comments.item(:new, t('general.new'), new_story_comment_path(@story)) if @comment
                              
                              if can? :edit, @comment
                                comments.item(:edit, t('general.edit'), edit_comment_path(@comment)) if @comment.try(:id)
                              end
                            end 
                          end
                        end
                      end
                      
                      task.item :comments, t('comments.index.title'), "#{story_path(@story)}#comments" do |comments|
                        comments.item(:new, t('general.new'), new_story_comment_path(@story)) if @comment
                        
                        if @comment.try(:id) && can?(:edit, @comment)
                          comments.item(:edit, t('general.edit'), edit_comment_path(@comment))
                        end
                      end 
                    end
                  end
                end
                
                story.item :comments, t('comments.index.title'), "#{story_path(@story)}#comments" do |comments|
                  comments.item(:new, t('general.new'), new_story_comment_path(@story)) if @comment
                  
                  if @comment.try(:id) && can?(:edit, @comment)
                    comments.item(:edit, t('general.edit'), edit_comment_path(@comment))
                  end
                end 
              end
            end
          end
          
          project.item :comments, t('comments.index.title'), "#{project_path(@project)}#comments" do |comments|
            comments.item(:new, t('general.new'), new_project_comment_path(@project)) if @comment
            
            if @comment.try(:id) && can?(:edit, @comment)
              comments.item(:edit, t('general.edit'), edit_comment_path(@comment))
            end
          end
        end
      end  
    end
    
    primary.item :vacancies, t('vacancies.index.title'), vacancies_path do |vacancies|
      vacancies.item :new, t('general.new'), new_vacancy_path
      
      unless (@vacancy.new_record? rescue true)
        vacancies.item :show, "#{@vacancy.name} @ #{@vacancy.project.name}", vacancy_path(@vacancy) do |vacancy|
          
          if can? :destroy, @vacancy
            vacancy.item :destroy, t('general.destroy'), vacancy_path(@vacancy), method: :delete, confirm: t('general.questions.are_you_sure')
          end
          
          vacancy.item :show, t('general.details'), "#{vacancy_path(@vacancy)}#top"
          vacancy.item :edit, t('general.edit'), edit_vacancy_path(@vacancy) if can? :edit, @vacancy
          
          vacancy.item :candidatures, t('candidatures.index.title'), vacancy_candidatures_path(@vacancy) do |candidatures|
            candidatures.item :new, t('general.new'), new_vacancy_candidature_path(@vacancy)
          
            unless (@candidature.new_record? rescue true)
              candidatures.item(
                :show, t('activerecord.models.candidature') + " of #{@candidature.user.name} @ #{@candidature.vacancy.project.name}", 
                candidature_path(@candidature) 
              ) do |candidature|
                if can? :destroy, @candidature
                  candidature.item :destroy, t('general.destroy'), candidature_path(@candidature), method: :delete, confirm: t('general.questions.are_you_sure')
                end
                
                candidature.item :show, t('general.details'), "#{candidature_path(@candidature)}#top"
                candidature.item :edit, t('general.edit'), edit_candidature_path(@candidature) if can? :edit, @candidature
                
                candidature.item :comments, t('comments.index.title'), "#{candidature_path(@candidature)}#comments" do |comments|
                  comments.item(:new, t('general.new'), new_candidature_comment_path(@candidature)) if @comment
                  
                  if @comment.try(:id) && can?(:edit, @comment)
                    comments.item(:edit, t('general.edit'), edit_comment_path(@comment))
                  end
                end 
              end
            end
          end
           
          vacancy.item :comments, t('comments.index.title'), "#{vacancy_path(@vacancy)}#comments" do |comments|
            comments.item(:new, t('general.new'), new_vacancy_comment_path(@vacancy)) if @comment && !@candidature
            
            if @comment.try(:id) && can?(:edit, @comment)
              comments.item(:edit, t('general.edit'), edit_comment_path(@comment)) 
            end
          end 
        end
      end  
    end
    
    primary.item :users, t('users.index.title'), users_path do |users|
      unless (@user.new_record? rescue true) || current_user.try(:id) == @user.id
        users.item :show, t('general.details'), "#{user_path(@user)}#top"
        
        users.item :projects, t('projects.index.title'), user_projects_path(@user)
        users.item :candidatures, t('candidatures.index.title'), user_candidatures_path(@user)
      end
    end
 
    if user_signed_in?
      primary.item :workflow, t('workflow.index.title'), workflow_path do |workflow|
        workflow.item :project_owner, t('workflow.project_owner.index.title'), workflow_project_owner_index_path do |project_owner|
          project_owner.item :vacancies, t('vacancies.index.title'), open_workflow_vacancies_path do |vacancies|
            Vacancy::STATES.each do |state|
              vacancies.item state, t("vacancies.show.states.#{state}"), eval("#{state}_workflow_vacancies_path")
            end
          end
            
          project_owner.item :candidatures, t('candidatures.index.title'), new_workflow_candidatures_path do |candidatures|
            Candidature::STATES.each do |state|
              candidatures.item state, t("candidatures.show.states.#{state}"), eval("#{state}_workflow_candidatures_path")
            end
          end
        end
        
        workflow.item :user, t('workflow.user.index.title'), workflow_user_index_path do |user|
          { 
            'no-name' => t('workflow.user.products.no_name.title'),
            'text-creation' => 'Text Creation'
          }.each do |slug, text|
            user.item slug.gsub('-', '_').to_sym, text, product_workflow_user_index_path(slug) do |product|
              product_slug = @story ? (@story.product.try(:to_param) || 'no-name') : 'no-name'
              
              unless (@story.new_record? rescue true) || product_slug != slug
                product.item(:show, @story.name, story_path(@story)) do |story|
                  story.item :show, t('general.details'), "#{story_path(@story)}#top"
                
                  story.item :tasks, t('tasks.index.title'), tasks_workflow_user_index_path(@story) do |tasks|
                    unless (@task.new_record? rescue true)
                      tasks.item(:edit, @task.name, edit_task_workflow_user_index_path(@task))
                    end
                  end
                end
              end
              
              product.item :next_task, t('workflow.user.tasks.next.title'), next_task_workflow_user_index_path('text-creation')
            end
          end
        end
      end
            
      primary.item :profile, t('users.show.title'), user_path(current_user) do |profile|
        profile.item :show, t('users.show.title'), user_path(current_user) do |user|
          user.item :show, t('users.show.title'), "#{user_path(current_user)}#top"
          user.item :settings, t('users.edit.title'), edit_user_path(current_user)
          user.item :preferences, t('users.preferences.title'), preferences_user_path(current_user)
          user.item :projects, t('projects.index.title'), user_projects_path(current_user)
          user.item :candidatures, t('candidatures.index.title'), user_candidatures_path(current_user)
        end
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