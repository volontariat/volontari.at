# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150106183434)
class AddProductMusicMetadataEnrichment < ActiveRecord::Migration
  def up
    if Product.where(name: 'Music Metadata Enrichment').first
    else
      Product.create(name: 'Music Metadata Enrichment', text: 'Dummy') 
    end
  
    create_table :music_artists do |t|
      t.string :mbid, limit: 36
      t.string :name
      t.string :country
      t.string :disambiguation
      t.integer :listeners
      t.integer :plays
      t.datetime :founded_at
      t.datetime :dissolved_at
      t.string :state
      t.timestamps
    end

    add_index :music_artists, :mbid, unique: true
    
    create_table :music_releases do |t|
      t.string :mbid, limit: 36
      t.integer :artist_id
      t.string :artist_name
      t.string :name
      t.integer :tracks_count
      t.string :future_release_date
      t.datetime :released_at
      t.integer :listeners
      t.integer :plays
      t.integer :user_id
      t.string :state
      t.timestamps
    end
    
    add_index :music_releases, :artist_id
    add_index :music_releases, :mbid, unique: true
    add_index :music_releases, :released_at
    
    create_table :music_tracks do |t|
      t.string :mbid, limit: 36
      t.string :spotify_track_id, limit: 22
      t.integer :artist_id
      t.string :artist_name
      t.integer :release_id
      t.string :release_name
      t.integer :master_track_id
      t.integer :nr
      t.string :name
      t.integer :duration
      t.integer :listeners
      t.integer :plays
      t.datetime :released_at
      t.string :state
      t.timestamps
    end
    
    add_index :music_tracks, :artist_id
    add_index :music_tracks, :master_track_id
    add_index :music_tracks, [:release_id, :name], unique: true
    add_index :music_tracks, :released_at
    
    create_table :music_videos do |t|
      t.string :status
      t.integer :artist_id
      t.string :artist_name
      t.integer :track_id
      t.string :track_name
      t.string :url
      t.string :location
      t.datetime :recorded_at
      t.integer :user_id
      t.integer :likes_count, default: 0
      t.integer :dislikes_count, default: 0
      t.string :state
      t.timestamps
    end
    
    add_index :music_videos, [:status, :track_id], unique: true
    add_index :music_videos, :url, unique: true
    add_index :music_videos, :track_id
    
    add_column :users, :music_library_imported, :boolean, default: false
  end
  
  def down
    drop_table :music_artists
    drop_table :music_releases
    drop_table :music_tracks
    drop_table :music_videos
    
    remove_column :users, :music_library_imported
  end
end
