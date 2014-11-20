class SpotifyAlbumInfoJob
	include SuckerPunch::Job 

	require 'rspotify'

	def perform(albumCreated)

		albums = RSpotify::Album.search(albumCreated.title)
    artist = albumCreated.artist_name

      for album in albums
        if album.artists[0].name == artist

          image = album.images[0]
            
            year = nil
            if album.release_date_precision == 'year'
              year = album.release_date
            end

            albumCreated.update_columns(album_art: image['url'], spotify_identifier: album.id, year: year)

            tracks = Array.new

            for track in album.tracks

              new_track = Track.new
              new_track.name = track.name
              new_track.album_id = albumCreated.id
              new_track.order = track.disc_number * track.track_number
              new_track.duration_milli = track.duration_ms
              new_track.spotify_identifier = track.id
              tracks.push(new_track.as_json)
            end

            Rails.logger.debug "This is my tracks!"
            Rails.logger.debug tracks.inspect
            Rails.logger.debug "This is self!"
            Rails.logger.debug self
            Track.create(tracks)

            break;
          end
        end
    end
end