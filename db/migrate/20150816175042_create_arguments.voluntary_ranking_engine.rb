# This migration comes from voluntary_ranking_engine (originally 20140926102943)
class CreateArguments < ActiveRecord::Migration
  def change
    create_table :argument_topics do |t|
      t.string :name
      t.text :text
      t.timestamps
    end
    
    add_index :argument_topics, :name, unique: true
    
    create_table :arguments do |t|
      t.integer :topic_id
      t.integer :thing_id
      t.string :value
      t.timestamps
    end
    
    add_index :arguments, [:topic_id, :thing_id], unique: true
  end
end