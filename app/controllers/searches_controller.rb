class SearchesController < ApplicationController
	
	require 'musicbrainz'

	respond_to :json, :html

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

		@tracks = @albums.releases.first.tracks

		respond_with @tracks.as_json
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

		album_artist = Artist.find_by(name: artist)

		if album_artist.blank?

	    	album_artist = Artist.new
	    	album_artist.name = artist
	    	album_artist.save
	    end

	    newAlbum.artist_id = album_artist.id

		if newAlbum.save

			link_to_album = edit_artist_album_path(newAlbum.artist.id, newAlbum.id)

			@mbTracks = releaseGroup.releases.first.tracks

			tracks = Array.new

            for track in @mbTracks

              new_track = Track.new
              new_track.name = track.title
              new_track.album_id = newAlbum.id
              new_track.order = track.position
              new_track.duration_milli = track.length
              tracks.push(new_track.as_json)
            end

            Track.create(tracks)

			SpotifyAlbumInfoJob.new.async.perform(newAlbum)
			ItunesAlbumInfoJob.new.async.perform(newAlbum)

        end

        Rails.logger.debug(link_to_album.to_json)

		respond_with '{"link": "'+link_to_album+'"}'

	end
end