class AddMusicBrainzIdentifierToAlbum < ActiveRecord::Migration
  def change
  	    add_column :albums, :musicbrainz_identifier, :string
  end
end
