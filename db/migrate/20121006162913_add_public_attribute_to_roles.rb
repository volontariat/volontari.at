class AddPublicAttributeToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :public, :boolean, default: false
    add_column :users, :main_role_id, :integer
  end
end
