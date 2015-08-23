# This migration comes from voluntary_engine (originally 20150818151512)
class CreateOrAlterArguments < ActiveRecord::Migration
  def up
    if (Product::Ranking rescue nil)
      add_column :arguments, :argumentable_type, :string
      add_column :arguments, :argumentable_id, :integer
      
      Argument.update_all "argumentable_type = 'Thing', argumentable_id = thing_id"
      
      remove_column :arguments, :thing_id
      add_index :arguments, [:topic_id, :argumentable_id, :argumentable_type], name: 'arguments_index_on_argumentable_topic', unique: true
      add_index :arguments, [:argumentable_id, :argumentable_type], name: 'arguments_index_on_argumentable'
    else
      create_table :argument_topics do |t|
        t.string :name
        t.text :text
        t.timestamps
      end
      
      add_index :argument_topics, :name, unique: true
      
      create_table :arguments do |t|
        t.string :argumentable_type
        t.integer :argumentable_id
        t.integer :topic_id
        t.string :value
        t.timestamps
      end
      
      add_index :arguments, [:topic_id, :argumentable_id, :argumentable_type], name: 'arguments_index_on_argumentable_topic', unique: true
      add_index :arguments, [:argumentable_id, :argumentable_type], name: 'arguments_index_on_argumentable'
    end
  end
  
  def down
    if (Product::Ranking rescue nil)
      add_column :arguments, :thing_id, :integer
      
      Argument.where(argumentable_type: 'Thing').update_all 'thing_id = argumentable_id'
      
      remove_column :arguments, :argumentable_type
      remove_column :arguments, :argumentable_id
      
      add_index :arguments, [:topic_id, :thing_id], unique: true
    else
      remove_table :argument_topics
      remove_table :arguments
    end
  end
end
