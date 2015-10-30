# This migration comes from voluntary_recruiting_engine (originally 20151012141951)
class AddTimespanToVacancy < ActiveRecord::Migration
  def up
    add_column :vacancies, :timezone, :string
    add_column :vacancies, :from, :datetime
    add_column :vacancies, :to, :datetime
    remove_index :vacancies, name: 'index_vacancies_on_project_id_and_name'
    add_column :candidatures, :user_id, :integer
    
    Candidature.where(resource_type: 'User').update_all('user_id = resource_id')
  end
  
  def down
    remove_column :vacancies, :timezone
    remove_column :vacancies, :from
    remove_column :vacancies, :to
    add_index :vacancies, [:project_id, :name], unique: true
    remove_column :candidatures, :user_id
  end
end
