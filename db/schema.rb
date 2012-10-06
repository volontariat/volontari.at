# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121006170407) do

  create_table "areas", :force => true do |t|
    t.string   "ancestry"
    t.integer  "ancestry_depth", :default => 0
    t.integer  "position"
    t.string   "name"
    t.string   "slug"
    t.integer  "users_count",    :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "areas", ["ancestry"], :name => "index_areas_on_ancestry"
  add_index "areas", ["name"], :name => "index_areas_on_name", :unique => true
  add_index "areas", ["slug"], :name => "index_areas_on_slug", :unique => true

  create_table "areas_projects", :force => true do |t|
    t.integer "area_id"
    t.integer "project_id"
  end

  add_index "areas_projects", ["area_id", "project_id"], :name => "index_areas_projects_on_area_id_and_project_id", :unique => true
  add_index "areas_projects", ["area_id"], :name => "index_areas_projects_on_area_id"
  add_index "areas_projects", ["project_id"], :name => "index_areas_projects_on_project_id"

  create_table "areas_users", :force => true do |t|
    t.integer "area_id"
    t.integer "user_id"
  end

  add_index "areas_users", ["area_id", "user_id"], :name => "index_areas_users_on_area_id_and_user_id", :unique => true
  add_index "areas_users", ["area_id"], :name => "index_areas_users_on_area_id"
  add_index "areas_users", ["user_id"], :name => "index_areas_users_on_user_id"

  create_table "candidatures", :force => true do |t|
    t.integer  "vacancy_id"
    t.integer  "offeror_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "slug"
    t.text     "text"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "candidatures", ["slug"], :name => "index_candidatures_on_slug", :unique => true
  add_index "candidatures", ["user_id", "vacancy_id"], :name => "index_candidatures_on_user_id_and_vacancy_id", :unique => true
  add_index "candidatures", ["user_id"], :name => "index_candidatures_on_user_id"
  add_index "candidatures", ["vacancy_id", "name"], :name => "index_candidatures_on_vacancy_id_and_name", :unique => true
  add_index "candidatures", ["vacancy_id"], :name => "index_candidatures_on_vacancy_id"

  create_table "comments", :force => true do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.string   "ancestry"
    t.integer  "ancestry_depth",   :default => 0
    t.integer  "position"
    t.string   "name"
    t.text     "text"
    t.string   "state"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"
  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "mongo_db_documents", :force => true do |t|
    t.integer  "mongo_db_object_id"
    t.string   "klass_name"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "mongo_db_documents", ["mongo_db_object_id", "klass_name"], :name => "index_mongo_db_documents_on_mongo_db_object_id_and_klass_name", :unique => true

  create_table "professions", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "slug"
    t.text     "text"
    t.string   "url"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "product_id"
  end

  add_index "projects", ["product_id"], :name => "index_projects_on_product_id"
  add_index "projects", ["slug"], :name => "index_projects_on_slug", :unique => true
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "projects_users", :force => true do |t|
    t.integer "project_id"
    t.integer "vacancy_id"
    t.integer "role_id"
    t.integer "user_id"
    t.string  "state"
  end

  add_index "projects_users", ["project_id", "user_id", "vacancy_id"], :name => "index_projects_users_on_project_id_and_user_id_and_vacancy_id", :unique => true
  add_index "projects_users", ["project_id"], :name => "index_projects_users_on_project_id"
  add_index "projects_users", ["role_id"], :name => "index_projects_users_on_role_id"
  add_index "projects_users", ["user_id"], :name => "index_projects_users_on_user_id"
  add_index "projects_users", ["vacancy_id"], :name => "index_projects_users_on_vacancy_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "state"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "public",     :default => false
    t.string   "type"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "rpx_identifier"
    t.string   "password"
    t.text     "text"
    t.text     "serialized_private_key"
    t.string   "language"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "salutation"
    t.string   "marital_status"
    t.string   "family_status"
    t.date     "date_of_birth"
    t.string   "place_of_birth"
    t.string   "citizenship"
    t.string   "email",                   :default => "", :null => false
    t.string   "encrypted_password",      :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",         :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "password_salt"
    t.string   "state"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "country"
    t.string   "foreign_language"
    t.string   "interface_language"
    t.string   "employment_relationship"
    t.integer  "profession_id"
    t.integer  "main_role_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["profession_id"], :name => "index_users_on_profession_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

  create_table "users_roles", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.string  "state"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id", :unique => true

  create_table "vacancies", :force => true do |t|
    t.string   "type"
    t.integer  "project_id"
    t.integer  "offeror_id"
    t.integer  "author_id"
    t.integer  "user_id"
    t.integer  "project_user_id"
    t.string   "name"
    t.string   "slug"
    t.text     "text"
    t.integer  "limit",           :default => 1
    t.string   "state"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "vacancies", ["offeror_id"], :name => "index_vacancies_on_offeror_id"
  add_index "vacancies", ["project_id", "name"], :name => "index_vacancies_on_project_id_and_name", :unique => true
  add_index "vacancies", ["project_id"], :name => "index_vacancies_on_project_id"
  add_index "vacancies", ["project_user_id"], :name => "index_vacancies_on_project_user_id"
  add_index "vacancies", ["slug"], :name => "index_vacancies_on_slug", :unique => true
  add_index "vacancies", ["user_id"], :name => "index_vacancies_on_user_id"

end
