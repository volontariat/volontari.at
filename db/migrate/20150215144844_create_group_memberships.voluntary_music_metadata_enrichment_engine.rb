# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150213170604)
class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :music_metadata_enrichment_group_memberships do |t|
      t.integer :group_id
      t.integer :user_id
      t.timestamps
    end
    
    add_index :music_metadata_enrichment_group_memberships, [:group_id, :user_id], name: 'uniq_music_metadata_enrichment_group_membership'
  end
end
