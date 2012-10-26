# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
     
    # authentication
    when /^the sign in page$/
      new_user_session_path  
      
    # areas  
    when /the areas page/
      areas_path
    
    when /the area page/
      area_path(@area)
      
    when /the edit area page/
      edit_area_path(@area)

    # product
    when /the product page/
      product_path(@product)
      
    when /the edit product page/
      edit_product_path(@product)

    # projects
    when /the project page/
      project_path(@project)
      
    when /the edit project page/
      edit_project_path(@project)
    
    # vacancies
    when /the vacancy page/
      vacancy_path(@vacancy)
      
    when /the edit vacancy page/
      edit_vacancy_path(@vacancy)
    
    # candidatures
    when /the candidature page/
      candidature_path(@candidature)
      
    when /the edit candidature page/
      edit_candidature_path(@candidature)
      
    # stories
    when /the new project story page/
      new_project_story_path(@project)
      
    # workflow
    when /the workflow page/
      workflow_path
    
    when /the edit workflow task page/
      edit_task_workflow_user_index_path(@task || @story.tasks.last)
    
    when /the project owner's workflow page/
      workflow_project_owner_index_path
       
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
  
  def login_page
    path_to "the new user session page"
  end
end

World(NavigationHelpers)
