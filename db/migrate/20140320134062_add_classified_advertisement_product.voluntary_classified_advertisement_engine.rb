# This migration comes from voluntary_classified_advertisement_engine (originally 20130806131503)
class AddClassifiedAdvertisementProduct < ActiveRecord::Migration
  def up
    begin
      product = Product.new(name: 'Classified Advertisement', text: 'Classified Advertisement')
      product.user_id = User.where(name: 'Master').first.id
      product.save!
    rescue
    end
  end
  
  def down
    Product.where(name: 'Classified Advertisement').first.destroy
  end
end