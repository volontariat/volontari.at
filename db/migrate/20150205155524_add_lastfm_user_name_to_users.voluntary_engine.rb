# This migration comes from voluntary_engine (originally 20150119171210)
class AddLastfmUserNameToUsers < ActiveRecord::Migration
    def up
    add_column :users, :lastfm_user_name, :string
    
    change_column :users, :email, :string, null: true
  end
  
  def down
    remove_column :users, :lastfm_user_name
    
    change_column :users, :email, :string, null: false
  end
end
