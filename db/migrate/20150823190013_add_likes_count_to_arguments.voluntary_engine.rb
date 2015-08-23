# This migration comes from voluntary_engine (originally 20150823174056)
class AddLikesCountToArguments < ActiveRecord::Migration
  def change
    add_column :arguments, :likes_count, :integer, default: 0
    add_column :arguments, :dislikes_count, :integer, default: 0
  end
end
