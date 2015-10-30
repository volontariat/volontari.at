# This migration comes from voluntary_engine (originally 20151022163015)
class AddTimezoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :timezone, :string
  end
end
