# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150215120545)
class AddMatchesToYearInReviewsMusic < ActiveRecord::Migration
  def change
    add_column :year_in_review_music, :top_track_matches, :text
    add_column :year_in_review_music, :top_release_matches, :text
  end
end
