# This migration comes from voluntary_translation_engine (originally 20131006062915)
class AddTranslationProduct < ActiveRecord::Migration
  def up
    area = Area.where(name: 'General').first
    
    begin
      product = Product.new(name: 'Translation', text: 'Dummy', area_ids: [area.id])
      product.user_id = User.where(name: 'Master').first.id
      product.save!
    rescue
    end
  end

  def down
    Product.where(name: 'Translation').first.destroy
  end
end
