class SpotifyAlbumInfoJob
	include SuckerPunch::Job 

	require 'rspotify'

	def perform(albumCreated)

		albums = RSpotify::Album.search(albumCreated.title)
    artist = albumCreated.artist.name

    albumTracks = albumCreated.tracks.sort_by{|e| e.order}

      Rails.logger.debug(albumTracks)


      for album in albums
        if album.artists[0].name == artist
            
            spotify_link = album.external_urls['spotify']

            year = album.release_date
            obscurity = ((100 - album.artists[0].popularity) * (100 - album.popularity)) / 100

            albumCreated.update_columns(spotify_link: spotify_link, spotify_identifier: album.id, year: year, obscurity_rating: obscurity)

            if albumCreated.album_art.nil?

              if album.images.size > 0
              
                image = album.images[0]
                albumCreated.update_columns(album_art: image['url'])

              end
            end

            album.tracks.each_with_index do | track, index |

              if albumTracks[index].present?

                Rails.logger.debug(track.name)
                Rails.logger.debug(albumTracks[index].name)

                apostrophe_changed_name = track.name "'", "’"

                if track.name.casecmp(apostrophe_changed_name) == 0
                  spotify_link = track.external_urls['spotify']
                  albumTracks[index].update_attributes(spotify_identifier: track.id, spotify_link: spotify_link)
                end
              end
            end
        end
      end
    end
end