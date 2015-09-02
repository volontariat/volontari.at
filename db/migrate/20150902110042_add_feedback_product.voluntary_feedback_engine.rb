# This migration comes from voluntary_feedback_engine (originally 20150825160004)
class AddFeedbackProduct < ActiveRecord::Migration
  def up
    if Product::Feedback.first
    else
      Product::Feedback.create(name: 'Feedback', text: 'Dummy') 
    end
    
    create_table :communities, force:  true do |t|
      t.integer :organization_id
      t.string :name
      t.string :slug
      t.text :text
      t.timestamps
    end
    
    add_index :communities, :organization_id
    add_index :communities, :slug, unique: true
    
    create_table :community_categories, force: true do |t|
      t.integer :community_id
      t.string :name
      t.string :slug
      t.integer :feedbacks_count, default: 0
      t.timestamps
    end
    
    add_index :community_categories, [:community_id, :slug], unique: true
    
    create_table :community_category_feedbacks, force: true do |t|
      t.integer :category_id
      t.integer :feedback_id
    end
    
    add_index :community_category_feedbacks, :category_id
    add_index :community_category_feedbacks, :feedback_id
    
    create_table :feedbacks, force:  true do |t|
      t.integer :community_id
      t.string :feedback_type
      t.integer :user_id
      t.string :name
      t.string :slug
      t.text :text
      t.integer :mood_type
      t.string :mood_text
      t.integer :likes_count
      t.integer :dislikes_count
      t.timestamps
    end
    
    add_index :feedbacks, [:community_id, :feedback_type]
    add_index :feedbacks, [:community_id, :slug], unique: true
    
    create_table :replies, force:  true do |t|
      t.integer :feedback_id
      t.integer :reply_id
      t.integer :user_id
      t.text :text
      t.integer :likes_count
      t.integer :dislikes_count
      t.timestamps
    end
    
    add_index :replies, :feedback_id
    add_index :replies, :reply_id
  end
  
  def down
    if product = Product::Feedback.first
      product.destroy
    end
    
    drop_table :communities
    drop_table :community_categories
    drop_table :community_category_feedbacks
    drop_table :feedbacks
    drop_table :replies
  end
end