# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150120221419)
class CreateMusicLibraryArtists < ActiveRecord::Migration
  def change
    create_table :music_library_artists do |t|
      t.integer :user_id
      t.integer :artist_id
      t.integer :plays
      t.timestamps
    end
    
    add_index :music_library_artists, :user_id
  end
end
