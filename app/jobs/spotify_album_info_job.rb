class SpotifyAlbumInfoJob
	include SuckerPunch::Job 
	workers 4

	require 'rspotify'

	def perform(albumCreated)

		albums = RSpotify::Album.search(albumCreated.title)
  		artist = albumCreated.artist_name

  		for album in albums
  			if album.artists[0].name == artist

  				image = album.images.first

     			albumCreated.update_columns(album_art: image['url'], spotify_identifier: album.id)
  			end
  		end
	end
end