class CreateProfessions < ActiveRecord::Migration
  def change
    create_table :professions do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
    
    remove_column :users, :profession
    add_column :users, :profession_id, :integer
    add_index :users, :profession_id
  end
end
