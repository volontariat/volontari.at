# This migration comes from voluntary_brainstorming_engine (originally 20150818181847)
class AddBrainstormingProduct < ActiveRecord::Migration
  def up
    if Product::Brainstorming.first
    else
      Product::Brainstorming.create(name: 'Brainstorming', text: 'Dummy') 
    end
    
    create_table :brainstormings, force:  true do |t|
      t.integer :user_id
      t.string :name
      t.string :slug
      t.text :text
      t.timestamps
    end
    
    add_index :brainstormings, :user_id
    add_index :brainstormings, [:slug, :user_id], unique: true
    
    create_table :brainstorming_ideas, force:  true do |t|
      t.integer :brainstorming_id
      t.integer :user_id
      t.string :name
      t.text :text
      t.integer :votes_count, default: 0
      t.timestamps
    end
    
    add_index :brainstorming_ideas, :user_id
    add_index :brainstorming_ideas, [:brainstorming_id, :name], unique: true
    
    create_table :brainstorming_idea_votes, force: true do |t|
      t.integer :idea_id
      t.integer :user_id
      t.timestamps
    end

    add_index :brainstorming_idea_votes, :idea_id
    add_index :brainstorming_idea_votes, :user_id
    add_index :brainstorming_idea_votes, [:idea_id, :user_id], unique: true
  end
  
  def down
    if product = Product::Brainstorming.first
      product.destroy
    end
    
    drop_table :brainstormings
    drop_table :brainstorming_ideas
    drop_table :brainstorming_idea_votes
  end
end
