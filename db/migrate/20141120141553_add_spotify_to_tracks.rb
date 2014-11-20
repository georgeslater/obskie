class AddSpotifyToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :duration_milli, :integer
    add_column :tracks, :spotify_identifier, :string
  end
end
