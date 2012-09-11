class RemoveTimestampsFromHabtmTables < ActiveRecord::Migration
  TABLES = [
    :areas_projects, :areas_users, :projects_users, :users_roles
  ]
  
  def up
    # Have to remove timestamps from cause of:
    # PG::Error: ERROR:  null value in column "created_at" violates not-null constraint
    TABLES.each do |table|
      remove_column table, :created_at
      remove_column table, :updated_at
    end
  end

  def down
    TABLES.each do |table|
      add_column table, :created_at, :datetime, null: false
      add_column table, :updated_at, :datetime, null: false
    end
  end
end
