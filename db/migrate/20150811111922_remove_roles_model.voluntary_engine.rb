# This migration comes from voluntary_engine (originally 20150809120211)
class Role < ActiveRecord::Base
  attr_accessible :name
end

class Role::Master < Role
end

class UserRole < ActiveRecord::Base
  self.table_name = 'users_roles'
  
  belongs_to :user
  
  attr_accessible :user_id, :role_id
end

class RemoveRolesModel < ActiveRecord::Migration
  def up
    add_column :users, :roles, :integer, limit: 8, null: false, default: 0
    
    if role = Role.where(name: 'Master').first
      UserRole.where(role_id: role.id).find_each do |user_role|
        if user_role.role_id == role.id
          ActiveRecord::Base.connection.execute "UPDATE users SET roles = 1 WHERE id = #{user_role.user_id}"
        end
      end
    end
    
    drop_table :roles
    drop_table :users_roles
    remove_column :projects_users, :role_id
    remove_column :users, :main_role_id
  end
  
  def down
    create_table "roles", force: :cascade do |t|
      t.string   "name",       limit: 255
      t.string   "state",      limit: 255
      t.datetime "created_at",                             null: false
      t.datetime "updated_at",                             null: false
      t.boolean  "public",                 default: false
      t.string   "type",       limit: 255
    end
    
    create_table "users_roles", force: :cascade do |t|
      t.integer "role_id", limit: 4
      t.integer "user_id", limit: 4
      t.string  "state",   limit: 255
    end
  
    role = Role::Master.create(name: 'Master')
    
    User.with_roles(:master).each {|user| UserRole.create(user_id: user.id, role_id: role.id) }
    
    remove_column :users, :roles
  
    add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", unique: true, using: :btree

    add_column :projects_users, :role_id, :integer, limit: 4
    add_index "projects_users", ["role_id"], name: "index_projects_users_on_role_id", using: :btree
    
    add_column :users, :main_role_id, :integer, limit: 4
  end
end