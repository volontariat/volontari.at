# This migration comes from voluntary_engine (originally 20131018143613)
class ReplaceUserByPolymorphicResourceInCandidatures < ActiveRecord::Migration
  def up
    add_column :vacancies, :resource_type, :string
    add_column :vacancies, :resource_id, :integer
    
    Vacancy.update_all(resource_type: "User")
    Vacancy.update_all('resource_id = user_id')
    
    remove_column :vacancies, :user_id
    
    add_column :candidatures, :resource_type, :string
    add_column :candidatures, :resource_id, :integer
    
    Candidature.update_all(resource_type: "User")
    Candidature.update_all('resource_id = user_id')
    
    remove_column :candidatures, :user_id
    
    begin
      remove_index :candidatures, [:user_id, :vacancy_id]
    rescue
    end
    
    add_index :candidatures, [:resource_id, :resource_type, :vacancy_id], unique: true, name: 'index_candidatures_on_resource_and_vacancy'
  end

  def down
    add_column :vacancies, :user_id, :integer
    
    Vacancy.where('resource_type = "User"').update_all('user_id = resource_id')
    Vacancy.where('resource_type <> "User"').destroy_all
    
    remove_column :vacancies, :resource_type
    remove_column :vacancies, :resource_id
    
    add_column :candidatures, :user_id, :integer
    
    add_index :candidatures, [:user_id, :vacancy_id]
    
    Candidature.where('resource_type = "User"').update_all('user_id = resource_id')
    Candidature.where('resource_type <> "User"').destroy_all
    
    remove_column :candidatures, :resource_type
    remove_column :candidatures, :resource_id
  end
end