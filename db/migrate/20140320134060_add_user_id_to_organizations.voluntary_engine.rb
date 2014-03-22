# This migration comes from voluntary_engine (originally 20140307113214)
class AddUserIdToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :user_id, :integer
  end
end
