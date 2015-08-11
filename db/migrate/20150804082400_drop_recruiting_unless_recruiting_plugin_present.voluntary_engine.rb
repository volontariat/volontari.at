# This migration comes from voluntary_engine (originally 20150802141840)
class DropRecruitingUnlessRecruitingPluginPresent < ActiveRecord::Migration
  def up
    unless (Product::Recruiting rescue nil)
      drop_table :vacancies
      drop_table :candidatures
      remove_index 'projects_users', name: 'index_projects_users_on_project_id_and_user_id_and_vacancy_id'
      remove_column :projects_users, :vacancy_id
      add_index 'projects_users', ['project_id', 'user_id'], name: 'index_projects_users_on_project_id_and_user_id', unique: true, using: :btree
    end
  end
  
  def down
    unless (Product::Recruiting rescue nil)
      create_table 'vacancies', force: true do |t|
        t.string   'type'
        t.integer  'project_id'
        t.integer  'offeror_id'
        t.integer  'author_id'
        t.integer  'project_user_id'
        t.string   'name'
        t.string   'slug'
        t.text     'text'
        t.integer  'limit',           default: 1
        t.string   'state'
        t.datetime 'created_at',                  null: false
        t.datetime 'updated_at',                  null: false
        t.string   'resource_type'
        t.integer  'resource_id'
      end
    
      add_index 'vacancies', ['offeror_id'], name: 'index_vacancies_on_offeror_id', using: :btree
      add_index 'vacancies', ['project_id', 'name'], name: 'index_vacancies_on_project_id_and_name', unique: true, using: :btree
      add_index 'vacancies', ['project_id'], name: 'index_vacancies_on_project_id', using: :btree
      add_index 'vacancies', ['project_user_id'], name: 'index_vacancies_on_project_user_id', using: :btree
      add_index 'vacancies', ['slug'], name: 'index_vacancies_on_slug', unique: true, using: :btree
      
      create_table 'candidatures', force: true do |t|
        t.integer  'vacancy_id'
        t.integer  'offeror_id'
        t.string   'name'
        t.string   'slug'
        t.text     'text'
        t.string   'state'
        t.datetime 'created_at',    null: false
        t.datetime 'updated_at',    null: false
        t.string   'resource_type'
        t.integer  'resource_id'
      end
    
      add_index 'candidatures', ['resource_id', 'resource_type', 'vacancy_id'], name: 'index_candidatures_on_resource_and_vacancy', unique: true, using: :btree
      add_index 'candidatures', ['slug'], name: 'index_candidatures_on_slug', unique: true, using: :btree
      add_index 'candidatures', ['vacancy_id', 'name'], name: 'index_candidatures_on_vacancy_id_and_name', unique: true, using: :btree
      add_index 'candidatures', ['vacancy_id'], name: 'index_candidatures_on_vacancy_id', using: :btree
      
      add_column 'projects_users', 'vacancy_id', :integer
      remove_index 'projects_users', name: 'index_projects_users_on_project_id_and_user_id'
      add_index 'projects_users', ['project_id', 'user_id', 'vacancy_id'], name: 'index_projects_users_on_project_id_and_user_id_and_vacancy_id', unique: true, using: :btree
    end
  end
end
