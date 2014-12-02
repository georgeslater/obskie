class SearchesController < ApplicationController
	
	require 'musicbrainz'

	respond_to :json

	def query

		@albums = MusicBrainz::ReleaseGroup.search(params[:artist], params[:album])

		@albumsJson = @albums.as_json
		respond_with @albumsJson
	end

	def get_tracks

		release = params[:album_selected]

		@albums = MusicBrainz::ReleaseGroup.find(release)

		respond_with @albums.releases.first.tracks.as_json
	end
end