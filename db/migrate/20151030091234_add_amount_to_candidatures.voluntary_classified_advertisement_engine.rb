# This migration comes from voluntary_classified_advertisement_engine (originally 20151021161627)
class AddAmountToCandidatures < ActiveRecord::Migration
  def change
    add_column :candidatures, :amount, :integer
  end
end
