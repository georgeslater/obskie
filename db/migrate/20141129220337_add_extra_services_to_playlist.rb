class AddExtraServicesToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :deezer_uri, :string
    add_column :playlists, :rdio_uri, :string
  end
end
