class AddSpotifyLinkToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :spotify_link, :string
  end
end
