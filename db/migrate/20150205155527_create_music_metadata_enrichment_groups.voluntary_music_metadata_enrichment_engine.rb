# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150120091801)
class CreateMusicMetadataEnrichmentGroups < ActiveRecord::Migration
  def up
    create_table :music_metadata_enrichment_groups do |t|
      t.string :name
      t.integer :user_id
      t.string :current_user_name
      t.integer :current_members_page
      t.integer :synced
      t.timestamps
    end
    
    create_table :music_metadata_enrichment_group_artist_connections do |t|
      t.integer :group_id
      t.integer :artist_id
      t.integer :likes_count, default: 0
      t.integer :dislikes_count, default: 0
      t.timestamps
    end

    add_index :music_metadata_enrichment_group_artist_connections, :group_id, name: 'index_music_group_artist_connections_on_group_id'
    add_index :music_metadata_enrichment_group_artist_connections, :artist_id, name: 'index_music_group_artist_connections_on_artist_id'
  end
  
  def down
    drop_table :music_metadata_enrichment_groups
    drop_table :music_metadata_enrichment_group_artist_connections
  end
end