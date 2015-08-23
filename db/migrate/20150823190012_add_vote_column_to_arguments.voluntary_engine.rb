# This migration comes from voluntary_engine (originally 20150821102558)
class AddVoteColumnToArguments < ActiveRecord::Migration
  def change
    add_column :arguments, :user_id, :integer
    add_column :arguments, :vote, :boolean
  end
end
