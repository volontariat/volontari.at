class CreateMongoDbDocuments < ActiveRecord::Migration
  def change
    create_table :mongo_db_documents do |t|
      t.integer :mongo_db_object_id
      t.string :klass_name
      t.string :name
      t.string :slug
      t.timestamps
    end
    
    add_index :mongo_db_documents, [:mongo_db_object_id, :klass_name], unique: true
  end
end
