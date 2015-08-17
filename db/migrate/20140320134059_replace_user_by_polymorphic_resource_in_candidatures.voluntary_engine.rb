# This migration comes from voluntary_engine (originally 20131018143613)
class ReplaceUserByPolymorphicResourceInCandidatures < ActiveRecord::Migration
  def up
    add_column :vacancies, :resource_type, :string
    add_column :vacancies, :resource_id, :integer
    
    if (Product::Recruiting rescue nil)
      Vacancy.where('user_id IS NOT NULL').update_all(resource_type: "User")
      Vacancy.where('user_id IS NOT NULL').update_all('resource_id = user_id')
    end
    
    remove_column :vacancies, :user_id
    
    add_column :candidatures, :resource_type, :string
    add_column :candidatures, :resource_id, :integer
    
    if (Product::Recruiting rescue nil)
      Candidature.where('user_id IS NOT NULL').update_all(resource_type: "User")
      Candidature.where('user_id IS NOT NULL').update_all('resource_id = user_id')
    end
    
    remove_column :candidatures, :user_id
    
    begin
      remove_index :candidatures, [:user_id, :vacancy_id]
    rescue
    end
    
    add_index :candidatures, [:resource_id, :resource_type, :vacancy_id], unique: true, name: 'index_candidatures_on_resource_and_vacancy'
  end

  def down
    add_column :vacancies, :user_id, :integer
    
    if (Product::Recruiting rescue nil)
      Vacancy.where('resource_type = "User"').update_all('user_id = resource_id')
      Vacancy.where('resource_type <> "User"').destroy_all
    end
    
    remove_column :vacancies, :resource_type
    remove_column :vacancies, :resource_id
    
    add_column :candidatures, :user_id, :integer
    
    add_index :candidatures, [:user_id, :vacancy_id]
    
    if (Product::Recruiting rescue nil)
      Candidature.where('resource_type = "User"').update_all('user_id = resource_id')
      Candidature.where('resource_type <> "User"').destroy_all
    end
    
    remove_column :candidatures, :resource_type
    remove_column :candidatures, :resource_id
  end
end