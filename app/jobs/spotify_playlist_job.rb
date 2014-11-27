class SpotifyPlaylistJob
	include SuckerPunch::Job

require 'rspotify'

	def perform(playlistCreated)

		RSpotify.authenticate("16b1bb336d3c40b28b6c8f07f9fb885b", "537bef59a7ad4f5192e96f7c66c39b8c")

		uri_keys = playlistCreated.spotify_uri.split(':')
		user = uri_keys[2]
		id = uri_keys[4]

		playlist = RSpotify::Playlist.find(user, id)

		if playlist.images.size > 0

			image_url = playlist.images[0]['url']
		end

	    playlistCreated.update_columns(name: playlist.name, description: playlist.description, followers: playlist.followers['total'], 
	    	image_url: image_url, track_count: playlist.tracks.size)
	end

end