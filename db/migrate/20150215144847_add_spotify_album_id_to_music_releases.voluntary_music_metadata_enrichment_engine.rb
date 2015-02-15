# This migration comes from voluntary_music_metadata_enrichment_engine (originally 20150215135051)
class AddSpotifyAlbumIdToMusicReleases < ActiveRecord::Migration
  def change
    add_column :music_releases, :spotify_album_id, :string, limit: 22
    add_column :year_in_review_music_releases, :spotify_album_id, :string, limit: 22
    add_column :year_in_review_music_release_flops, :spotify_album_id, :string, limit: 22
    add_column :music_metadata_enrichment_group_year_in_review_releases, :spotify_album_id, :string, limit: 22
  end
end
