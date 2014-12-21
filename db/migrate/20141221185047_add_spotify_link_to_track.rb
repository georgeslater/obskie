class AddSpotifyLinkToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :spotify_link, :string
  end
end
