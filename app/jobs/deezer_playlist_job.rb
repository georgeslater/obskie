class DeezerPlaylistJob
	include SuckerPunch::Job

	def perform(playlistCreated)

		response = HTTParty.get('http://api.deezer.com/playlist/'+playlistCreated.deezer_uri)

			playlist = response.body

			image_url = playlist['picture']
			
		    playlistCreated.update_columns(name: playlist['title'], description: playlist['description'], 
		    image_url: image_url, track_count: playlist['tracks'].size)
	end
end