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

ActiveRecord::Schema.define(version: 20150220125255) do

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

  create_table "likes", force: true do |t|
    t.boolean  "positive",               default: true
    t.integer  "target_id"
    t.string   "target_type", limit: 60,                null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["target_id", "user_id", "target_type"], name: "index_likes_on_target_id_and_user_id_and_target_type", unique: true, using: :btree

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

  create_table "music_artists", force: true do |t|
    t.string   "mbid",           limit: 36
    t.string   "name"
    t.string   "country"
    t.string   "disambiguation"
    t.integer  "listeners"
    t.integer  "plays"
    t.datetime "founded_at"
    t.datetime "dissolved_at"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_ambiguous"
  end

  add_index "music_artists", ["mbid"], name: "index_music_artists_on_mbid", unique: true, using: :btree

  create_table "music_library_artists", force: true do |t|
    t.integer  "user_id"
    t.integer  "artist_id"
    t.integer  "plays"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "music_library_artists", ["user_id"], name: "index_music_library_artists_on_user_id", using: :btree

  create_table "music_metadata_enrichment_group_artist_connections", force: true do |t|
    t.integer  "group_id"
    t.integer  "artist_id"
    t.integer  "likes_count",    default: 0
    t.integer  "dislikes_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "music_metadata_enrichment_group_artist_connections", ["artist_id"], name: "index_music_group_artist_connections_on_artist_id", using: :btree
  add_index "music_metadata_enrichment_group_artist_connections", ["group_id"], name: "index_music_group_artist_connections_on_group_id", using: :btree

  create_table "music_metadata_enrichment_group_memberships", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "music_metadata_enrichment_group_memberships", ["group_id", "user_id"], name: "uniq_music_metadata_enrichment_group_membership", using: :btree

  create_table "music_metadata_enrichment_group_year_in_review", force: true do |t|
    t.integer  "group_id"
    t.integer  "year"
    t.integer  "users_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "music_metadata_enrichment_group_year_in_review", ["group_id", "year"], name: "uniq_music_metadata_enrichment_group_year_in_review", using: :btree

  create_table "music_metadata_enrichment_group_year_in_review_releases", force: true do |t|
    t.integer  "year_in_review_music_id"
    t.integer  "group_id"
    t.integer  "year"
    t.integer  "position"
    t.float    "score"
    t.integer  "artist_id"
    t.string   "artist_name"
    t.integer  "release_id"
    t.string   "release_name"
    t.datetime "released_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotify_album_id",        limit: 22
  end

  add_index "music_metadata_enrichment_group_year_in_review_releases", ["year_in_review_music_id", "position"], name: "uniq_music_metadata_enrichment_group_year_in_review_release", using: :btree

  create_table "music_metadata_enrichment_group_year_in_review_tracks", force: true do |t|
    t.integer  "year_in_review_music_id"
    t.integer  "group_id"
    t.integer  "year"
    t.integer  "position"
    t.float    "score"
    t.integer  "artist_id"
    t.string   "artist_name"
    t.integer  "release_id"
    t.string   "release_name"
    t.integer  "track_id"
    t.string   "spotify_track_id",        limit: 22
    t.string   "track_name"
    t.datetime "released_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "music_metadata_enrichment_group_year_in_review_tracks", ["year_in_review_music_id", "position"], name: "uniq_music_metadata_enrichment_group_year_in_review_track", using: :btree

  create_table "music_metadata_enrichment_groups", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "current_user_name"
    t.integer  "current_members_page"
    t.integer  "synced"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "music_releases", force: true do |t|
    t.string   "mbid",                limit: 36
    t.integer  "artist_id"
    t.string   "artist_name"
    t.string   "name"
    t.integer  "tracks_count"
    t.string   "future_release_date"
    t.datetime "released_at"
    t.integer  "listeners"
    t.integer  "plays"
    t.integer  "user_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_lp",                          default: false, null: false
    t.string   "spotify_album_id",    limit: 22
  end

  add_index "music_releases", ["artist_id"], name: "index_music_releases_on_artist_id", using: :btree
  add_index "music_releases", ["mbid"], name: "index_music_releases_on_mbid", unique: true, using: :btree
  add_index "music_releases", ["released_at"], name: "index_music_releases_on_released_at", using: :btree

  create_table "music_tracks", force: true do |t|
    t.string   "mbid",             limit: 36
    t.string   "spotify_track_id", limit: 22
    t.integer  "artist_id"
    t.string   "artist_name"
    t.integer  "release_id"
    t.string   "release_name"
    t.integer  "master_track_id"
    t.integer  "nr"
    t.string   "name"
    t.integer  "duration"
    t.integer  "listeners"
    t.integer  "plays"
    t.datetime "released_at"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "music_tracks", ["artist_id"], name: "index_music_tracks_on_artist_id", using: :btree
  add_index "music_tracks", ["master_track_id"], name: "index_music_tracks_on_master_track_id", using: :btree
  add_index "music_tracks", ["release_id", "name"], name: "index_music_tracks_on_release_id_and_name", unique: true, using: :btree
  add_index "music_tracks", ["released_at"], name: "index_music_tracks_on_released_at", using: :btree

  create_table "music_videos", force: true do |t|
    t.string   "status"
    t.integer  "artist_id"
    t.string   "artist_name"
    t.integer  "track_id"
    t.string   "track_name"
    t.string   "url"
    t.string   "location"
    t.datetime "recorded_at"
    t.integer  "user_id"
    t.integer  "likes_count",    default: 0
    t.integer  "dislikes_count", default: 0
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "music_videos", ["status", "track_id"], name: "index_music_videos_on_status_and_track_id", unique: true, using: :btree
  add_index "music_videos", ["track_id"], name: "index_music_videos_on_track_id", using: :btree
  add_index "music_videos", ["url"], name: "index_music_videos_on_url", unique: true, using: :btree

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
    t.string   "email",                   default: ""
    t.string   "encrypted_password",      default: "",    null: false
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
    t.string   "provider"
    t.string   "uid"
    t.string   "lastfm_user_name"
    t.boolean  "music_library_imported",  default: false
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

  create_table "year_in_review_music", force: true do |t|
    t.integer  "user_id"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "top_track_matches"
    t.text     "top_release_matches"
    t.string   "state",               default: "draft"
  end

  add_index "year_in_review_music", ["user_id", "year"], name: "index_year_in_review_music_on_user_id_and_year", using: :btree

  create_table "year_in_review_music_release_flops", force: true do |t|
    t.integer  "year_in_review_music_id"
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "artist_id"
    t.string   "artist_name"
    t.integer  "release_id"
    t.string   "release_name"
    t.datetime "released_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotify_album_id",        limit: 22
  end

  add_index "year_in_review_music_release_flops", ["year_in_review_music_id", "release_id"], name: "year_in_review_music_release_flop_releases", using: :btree

  create_table "year_in_review_music_releases", force: true do |t|
    t.integer  "year_in_review_music_id"
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "position"
    t.integer  "artist_id"
    t.string   "artist_name"
    t.integer  "release_id"
    t.string   "release_name"
    t.datetime "released_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotify_album_id",        limit: 22
    t.string   "state",                              default: "draft"
  end

  add_index "year_in_review_music_releases", ["year_in_review_music_id", "position"], name: "uniq_year_in_review_music_release", using: :btree

  create_table "year_in_review_music_track_flops", force: true do |t|
    t.integer  "year_in_review_music_id"
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "artist_id"
    t.string   "artist_name"
    t.integer  "release_id"
    t.string   "release_name"
    t.integer  "track_id"
    t.string   "spotify_track_id",        limit: 22
    t.string   "track_name"
    t.datetime "released_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "year_in_review_music_track_flops", ["year_in_review_music_id", "track_id"], name: "year_in_review_music_release_flop_tracks", using: :btree

  create_table "year_in_review_music_tracks", force: true do |t|
    t.integer  "year_in_review_music_id"
    t.integer  "user_id"
    t.integer  "year"
    t.integer  "position"
    t.integer  "artist_id"
    t.string   "artist_name"
    t.integer  "release_id"
    t.string   "release_name"
    t.integer  "track_id"
    t.string   "spotify_track_id",        limit: 22
    t.string   "track_name"
    t.datetime "released_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                              default: "draft"
  end

  add_index "year_in_review_music_tracks", ["year_in_review_music_id", "position"], name: "uniq_year_in_review_music_track", using: :btree

end
