# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150209151056)
class AddIsAmbiguousToMusicArtists < ActiveRecord::Migration
  def change
    add_column :music_artists, :is_ambiguous, :boolean, default: nil
  end
end
