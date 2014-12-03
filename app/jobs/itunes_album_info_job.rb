class ItunesAlbumInfoJob
	include SuckerPunch::Job 

	def perform(albumCreated)

		albums = ITunesSearchAPI.search(:term => albumCreated.title, :country => "US", :media => "music", :attribute => "albumTerm")
	    artist = albumCreated.artist.name
		
		for album in albums

			if album['artistName'] == artist

				albumCreated.update_columns(itunes_identifier: album['collectionId'], itunes_view_url: album['collectionViewUrl'])
				break;
			end
		end
	end
end