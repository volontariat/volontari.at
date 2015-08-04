# This migration comes from voluntary_recruiting_engine (originally 20150711124651)
class AddRecruiting < ActiveRecord::Migration
  def up
    if product = Product.where(name: 'Recruiting').first
    else
      Product.create(name: 'Recruiting', text: 'Dummy')
    end
    
    unless ActiveRecord::Base.connection.table_exists? 'vacancies'
      create_table "vacancies", force: true do |t|
        t.string   "type"
        t.integer  "project_id"
        t.integer  "offeror_id"
        t.integer  "author_id"
        t.integer  "project_user_id"
        t.string   "name"
        t.string   "slug"
        t.text     "text"
        t.integer  "limit",           default: 1
        t.string   "state"
        t.datetime "created_at",                  null: false
        t.datetime "updated_at",                  null: false
        t.string   "resource_type"
        t.integer  "resource_id"
      end
    
      add_index "vacancies", ["offeror_id"], name: "index_vacancies_on_offeror_id", using: :btree
      add_index "vacancies", ["project_id", "name"], name: "index_vacancies_on_project_id_and_name", unique: true, using: :btree
      add_index "vacancies", ["project_id"], name: "index_vacancies_on_project_id", using: :btree
      add_index "vacancies", ["project_user_id"], name: "index_vacancies_on_project_user_id", using: :btree
      add_index "vacancies", ["slug"], name: "index_vacancies_on_slug", unique: true, using: :btree
    end
    
    unless ActiveRecord::Base.connection.table_exists? 'candidatures'
      create_table "candidatures", force: true do |t|
        t.integer  "vacancy_id"
        t.integer  "offeror_id"
        t.string   "name"
        t.string   "slug"
        t.text     "text"
        t.string   "state"
        t.datetime "created_at",    null: false
        t.datetime "updated_at",    null: false
        t.string   "resource_type"
        t.integer  "resource_id"
      end
    
      add_index "candidatures", ["resource_id", "resource_type", "vacancy_id"], name: "index_candidatures_on_resource_and_vacancy", unique: true, using: :btree
      add_index "candidatures", ["slug"], name: "index_candidatures_on_slug", unique: true, using: :btree
      add_index "candidatures", ["vacancy_id", "name"], name: "index_candidatures_on_vacancy_id_and_name", unique: true, using: :btree
      add_index "candidatures", ["vacancy_id"], name: "index_candidatures_on_vacancy_id", using: :btree
    end
  end
  
  def down
    product.destroy if product = Product::Recruiting.first
    
    drop_table :vacancies
    drop_table :candidatures
  end
end
