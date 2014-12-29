class AddMusicBrainzIdentifierToArtist < ActiveRecord::Migration
  def change
  	  	add_column :artists, :musicbrainz_identifier, :string
  	    add_column :tracks, :musicbrainz_identifier, :string
  end
end
