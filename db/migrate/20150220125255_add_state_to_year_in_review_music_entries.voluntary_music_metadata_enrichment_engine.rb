# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150220084746)
class AddStateToYearInReviewMusicEntries < ActiveRecord::Migration
  def change
    add_column :year_in_review_music, :state, :string, default: 'draft'
    add_column :year_in_review_music_releases, :state, :string, default: 'draft'
    add_column :year_in_review_music_tracks, :state, :string, default: 'draft'
  end
end
