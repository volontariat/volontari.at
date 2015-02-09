# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150209091856)
class YearInReviewMusicReleasesAndTracksFlops < ActiveRecord::Migration
  def change
    create_table :year_in_review_music_release_flops do |t|
      t.integer :year_in_review_music_id
      t.integer :user_id
      t.integer :year
      t.integer :artist_id
      t.string :artist_name
      t.integer :release_id
      t.string :release_name
      t.datetime :released_at
      t.timestamps
    end
    
    add_index :year_in_review_music_release_flops, [:year_in_review_music_id, :release_id], name: 'year_in_review_music_release_flop_releases'
    
    create_table :year_in_review_music_track_flops do |t|
      t.integer :year_in_review_music_id
      t.integer :user_id
      t.integer :year
      t.integer :artist_id
      t.string :artist_name
      t.integer :release_id
      t.string :release_name
      t.integer :track_id
      t.string :spotify_track_id, limit: 22
      t.string :track_name
      t.datetime :released_at
      t.timestamps
    end
    
    add_index :year_in_review_music_track_flops, [:year_in_review_music_id, :track_id], name: 'year_in_review_music_release_flop_tracks'
  end
end
