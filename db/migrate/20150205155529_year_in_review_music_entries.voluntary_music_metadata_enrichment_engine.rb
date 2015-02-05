# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150123082224)
class YearInReviewMusicEntries < ActiveRecord::Migration
  def up
    create_table :year_in_review_music do |t|
      t.integer :user_id
      t.integer :year
      t.timestamps
    end
    
    add_index :year_in_review_music, :user_id
    add_index :year_in_review_music, :year
    
    create_table :year_in_review_music_releases do |t|
      t.integer :year_in_review_music_id
      t.integer :user_id
      t.integer :year
      t.integer :position
      t.integer :artist_id
      t.string :artist_name
      t.integer :release_id
      t.string :release_name
      t.datetime :released_at
      t.timestamps
    end
    
    add_index :year_in_review_music_releases, :year_in_review_music_id
    add_index :year_in_review_music_releases, :position
    
    create_table :year_in_review_music_tracks do |t|
      t.integer :year_in_review_music_id
      t.integer :user_id
      t.integer :year
      t.integer :position
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
    
    add_index :year_in_review_music_tracks, :year_in_review_music_id
    add_index :year_in_review_music_tracks, :position
  end
  
  def down
    drop_table :year_in_review_music
    drop_table :year_in_review_music_releases
    drop_table :year_in_review_music_tracks
  end
end
