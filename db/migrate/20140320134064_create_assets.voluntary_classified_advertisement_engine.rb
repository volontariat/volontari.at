# This migration comes from voluntary_classified_advertisement_engine (originally 20130830170731)
class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name
      t.text :text
      t.timestamps
    end
  end
end
