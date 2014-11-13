class AddArtistToAlbum < ActiveRecord::Migration
  def change
    add_reference :albums, :artist, index: true
  end
end
