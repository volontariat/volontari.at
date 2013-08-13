# This migration comes from voluntary_ranking_engine (originally 20130809171331)
class AddRankingProduct < ActiveRecord::Migration
  def up
    Product.create(name: 'Ranking', text: 'Ranking')
  end
  
  def down
    Product.where(name: 'Ranking').first.destroy
  end
end
