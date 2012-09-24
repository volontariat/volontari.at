class AddProductToProject < ActiveRecord::Migration
  def change
    add_column :projects, :product_id, :string
    add_index :projects, :product_id
  end
end
