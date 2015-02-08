# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150208120722)
class AddIsLpToMusicReleases < ActiveRecord::Migration
  def change
    add_column :music_releases, :is_lp, :boolean, null: false, default: false
  end
end
