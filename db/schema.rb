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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140320134069) do

  create_table "areas", force: true do |t|
    t.string   "ancestry"
    t.integer  "ancestry_depth", default: 0
    t.integer  "position"
    t.string   "name"
    t.string   "slug"
    t.integer  "users_count",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "areas", ["ancestry"], name: "index_areas_on_ancestry", using: :btree
  add_index "areas", ["name"], name: "index_areas_on_name", unique: true, using: :btree
  add_index "areas", ["slug"], name: "index_areas_on_slug", unique: true, using: :btree

  create_table "areas_projects", force: true do |t|
    t.integer "area_id"
    t.integer "project_id"
  end

  add_index "areas_projects", ["area_id", "project_id"], name: "index_areas_projects_on_area_id_and_project_id", unique: true, using: :btree
  add_index "areas_projects", ["area_id"], name: "index_areas_projects_on_area_id", using: :btree
  add_index "areas_projects", ["project_id"], name: "index_areas_projects_on_project_id", using: :btree

  create_table "areas_users", force: true do |t|
    t.integer "area_id"
    t.integer "user_id"
  end

  add_index "areas_users", ["area_id", "user_id"], name: "index_areas_users_on_area_id_and_user_id", unique: true, using: :btree
  add_index "areas_users", ["area_id"], name: "index_areas_users_on_area_id", using: :btree
  add_index "areas_users", ["user_id"], name: "index_areas_users_on_user_id", using: :btree

  create_table "assets", force: true do |t|
    t.string   "name"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "candidatures", force: true do |t|
    t.integer  "vacancy_id"
    t.integer  "offeror_id"
    t.string   "name"
    t.string   "slug"
    t.text     "text"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resource_type"
    t.integer  "resource_id"
  end

  add_index "candidatures", ["resource_id", "resource_type", "vacancy_id"], name: "index_candidatures_on_resource_and_vacancy", unique: true, using: :btree
  add_index "candidatures", ["slug"], name: "index_candidatures_on_slug", unique: true, using: :btree
  add_index "candidatures", ["vacancy_id", "name"], name: "index_candidatures_on_vacancy_id_and_name", unique: true, using: :btree
  add_index "candidatures", ["vacancy_id"], name: "index_candidatures_on_vacancy_id", using: :btree

  create_table "comments", force: true do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.string   "ancestry"
    t.integer  "ancestry_depth",   default: 0
    t.integer  "position"
    t.string   "name"
    t.text     "text"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree
  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "list_items", force: true do |t|
    t.integer  "list_id"
    t.integer  "user_id"
    t.string   "thing_type"
    t.integer  "thing_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lists", ["user_id"], name: "index_lists_on_user_id", using: :btree

  create_table "mongo_db_documents", force: true do |t|
    t.integer  "mongo_db_object_id"
    t.string   "klass_name"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mongo_db_documents", ["mongo_db_object_id", "klass_name"], name: "index_mongo_db_documents_on_mongo_db_object_id_and_klass_name", unique: true, using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "organizations", ["slug"], name: "index_organizations_on_slug", using: :btree

  create_table "professions", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "slug"
    t.text     "text"
    t.string   "url"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product_id"
    t.integer  "organization_id"
  end

  add_index "projects", ["organization_id"], name: "index_projects_on_organization_id", using: :btree
  add_index "projects", ["product_id"], name: "index_projects_on_product_id", using: :btree
  add_index "projects", ["slug"], name: "index_projects_on_slug", unique: true, using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "projects_users", force: true do |t|
    t.integer "project_id"
    t.integer "vacancy_id"
    t.integer "role_id"
    t.integer "user_id"
    t.string  "state"
  end

  add_index "projects_users", ["project_id", "user_id", "vacancy_id"], name: "index_projects_users_on_project_id_and_user_id_and_vacancy_id", unique: true, using: :btree
  add_index "projects_users", ["project_id"], name: "index_projects_users_on_project_id", using: :btree
  add_index "projects_users", ["role_id"], name: "index_projects_users_on_role_id", using: :btree
  add_index "projects_users", ["user_id"], name: "index_projects_users_on_user_id", using: :btree
  add_index "projects_users", ["vacancy_id"], name: "index_projects_users_on_vacancy_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",     default: false
    t.string   "type"
  end

  create_table "scholarship_iteration_participations", force: true do |t|
    t.integer  "iteration_id"
    t.integer  "user_id"
    t.integer  "roles"
    t.integer  "team_id"
    t.text     "text"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scholarship_iteration_participations", ["iteration_id", "user_id"], name: "index_scholarship_iteration_participations_on_iteration_user", unique: true, using: :btree

  create_table "scholarship_iterations", force: true do |t|
    t.integer  "program_id"
    t.string   "name"
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scholarship_iterations", ["program_id", "from", "to"], name: "index_scholarship_iterations_on_program_id_and_from_and_to", unique: true, using: :btree

  create_table "scholarship_programs", force: true do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scholarship_programs", ["organization_id", "name"], name: "index_scholarship_programs_on_organization_id_and_name", unique: true, using: :btree

  create_table "scholarship_team_memberships", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "roles"
    t.text     "text"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scholarship_team_memberships", ["team_id", "user_id"], name: "index_scholarship_team_memberships_on_team_id_and_user_id", unique: true, using: :btree

  create_table "scholarship_teams", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "text"
    t.string   "kind"
    t.string   "github_handle"
    t.string   "twitter_handle"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scholarship_teams", ["name"], name: "index_scholarship_teams_on_name", unique: true, using: :btree
  add_index "scholarship_teams", ["slug"], name: "index_scholarship_teams_on_slug", unique: true, using: :btree

  create_table "things", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "things", ["name"], name: "index_things_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
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
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",         default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "password_salt"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.string   "interface_language"
    t.string   "employment_relationship"
    t.integer  "profession_id"
    t.integer  "main_role_id"
    t.text     "foreign_languages"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["profession_id"], name: "index_users_on_profession_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "users_roles", force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.string  "state"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", unique: true, using: :btree

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "task_id"
  end

  add_index "vacancies", ["offeror_id"], name: "index_vacancies_on_offeror_id", using: :btree
  add_index "vacancies", ["project_id", "name"], name: "index_vacancies_on_project_id_and_name", unique: true, using: :btree
  add_index "vacancies", ["project_id"], name: "index_vacancies_on_project_id", using: :btree
  add_index "vacancies", ["project_user_id"], name: "index_vacancies_on_project_user_id", using: :btree
  add_index "vacancies", ["slug"], name: "index_vacancies_on_slug", unique: true, using: :btree

end
