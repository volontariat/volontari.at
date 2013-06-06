# This migration comes from voluntary_engine (originally 20121122185954)
class AddKlassNameToProducts < ActiveRecord::Migration
  def up
    Product.each do |product|
      next if product.klass_name.present?
      
      if product.name == 'Product'
        product.klass_name = 'Product'
      else
        product.klass_name = [
          'Product', product.name.gsub(' - ', '_').gsub('-', '_').gsub(' ', '_').classify
        ].join('::')
      end
      
      product.save!
    end
  end
end
