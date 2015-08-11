# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150811104720)
class AddClassicAndJazzTagsToMusicArtists < ActiveRecord::Migration
  def change
    add_column :music_artists, :is_classic, :boolean, null: false, default: false
    add_column :music_artists, :is_jazz, :boolean, null: false, default: false
  end
end
