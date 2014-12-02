class SearchesController < ApplicationController
	
	require 'musicbrainz'

	respond_to :json

	def get_artists

		artistSelected = params[:artist]

		artists = MusicBrainz::Artist.search(artistSelected)
		@artistsJson = artists.as_json
		respond_with @artistsJson
	end

	def get_albums

		@albums = MusicBrainz::Artist.find(params[:artist_selected]).release_groups

		@albumsJson = @albums.as_json
		respond_with @albumsJson
	end

	def get_tracks

		release = params[:album_selected]

		@albums = MusicBrainz::ReleaseGroup.find(release)

		respond_with @albums.releases.first.tracks.as_json
	end

	def submit

		artist = params[:artist_selected]
		release = params[:album_selected]

		releaseGroup = MusicBrainz::ReleaseGroup.find(release)
		
		newAlbum = Album.new
		newAlbum.title = releaseGroup.title
		newAlbum.user_id = current_user.id
		
		if releaseGroup.releases.first.date.present?
			yearPart = releaseGroup.releases.first.date.year
		end

		newAlbum.year = yearPart

		album_artist = Artist.find_by(name: params[:artist])

	    

	    newAlbum.artist_id = album_artist.id

		newAlbum.save

		render js: "window.location.pathname='#{new_album_step_2_path}?id="+newAlbum+"'"
	end
end