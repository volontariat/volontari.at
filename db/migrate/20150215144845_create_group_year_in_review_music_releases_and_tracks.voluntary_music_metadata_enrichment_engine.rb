# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150214083714)
class CreateGroupYearInReviewMusicReleasesAndTracks < ActiveRecord::Migration
    def up
    remove_index :year_in_review_music, :user_id
    remove_index :year_in_review_music, :year
    add_index :year_in_review_music, [:user_id, :year]
    
    remove_index :year_in_review_music_releases, :year_in_review_music_id
    remove_index :year_in_review_music_releases, :position
    add_index :year_in_review_music_releases, [:year_in_review_music_id, :position], name: 'uniq_year_in_review_music_release'
    
    remove_index :year_in_review_music_tracks, :year_in_review_music_id
    remove_index :year_in_review_music_tracks, :position
    add_index :year_in_review_music_tracks, [:year_in_review_music_id, :position], name: 'uniq_year_in_review_music_track'
    
    create_table :music_metadata_enrichment_group_year_in_review do |t|
      t.integer :group_id
      t.integer :year
      t.integer :users_count, default: 0
      t.timestamps
    end
    
    add_index :music_metadata_enrichment_group_year_in_review, [:group_id, :year], name: 'uniq_music_metadata_enrichment_group_year_in_review'#, unique: true
    
    create_table :music_metadata_enrichment_group_year_in_review_releases do |t|
      t.integer :year_in_review_music_id
      t.integer :group_id
      t.integer :year
      t.integer :position
      t.float :score
      t.integer :artist_id
      t.string :artist_name
      t.integer :release_id
      t.string :release_name
      t.datetime :released_at
      t.timestamps
    end
    
    add_index :music_metadata_enrichment_group_year_in_review_releases, [:year_in_review_music_id, :position], name: 'uniq_music_metadata_enrichment_group_year_in_review_release'#, unique: true
    
    create_table :music_metadata_enrichment_group_year_in_review_tracks do |t|
      t.integer :year_in_review_music_id
      t.integer :group_id
      t.integer :year
      t.integer :position
      t.float :score
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
    
    add_index :music_metadata_enrichment_group_year_in_review_tracks, [:year_in_review_music_id, :position], name: 'uniq_music_metadata_enrichment_group_year_in_review_track'#, unique: true
  end
  
  def down
    remove_index :year_in_review_music, [:user_id, :year]
    add_index :year_in_review_music, :user_id
    add_index :year_in_review_music, :year

    remove_index :year_in_review_music_releases, name: 'uniq_year_in_review_music_release'
    add_index :year_in_review_music_releases, :year_in_review_music_id
    add_index :year_in_review_music_releases, :position
    
    remove_index :year_in_review_music_tracks, name: 'uniq_year_in_review_music_track'
    add_index :year_in_review_music_tracks, :year_in_review_music_id
    add_index :year_in_review_music_tracks, :position
    
    drop_table :music_metadata_enrichment_group_year_in_review
    drop_table :music_metadata_enrichment_group_year_in_review_releases
    drop_table :music_metadata_enrichment_group_year_in_review_tracks
  end
end
