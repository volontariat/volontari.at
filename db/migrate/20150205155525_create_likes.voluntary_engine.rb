# This migration comes from voluntary_engine (originally 20150126185249)
class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean  :positive, default: true
      t.integer  :target_id
      t.string   :target_type, limit: 60, null: false
      t.integer  :user_id
      t.timestamps
    end
    
    add_index :likes, [:target_id, :user_id, :target_type], unique: true
  end
end
