# This migration comes from voluntary_engine (originally 20150119151714)
class AddProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
