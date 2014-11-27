class AddPlaylistInfoToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :description, :text
    add_column :playlists, :followers, :integer
    add_column :playlists, :image_url, :string
    add_column :playlists, :track_count, :integer
  end
end
