module AlbumsHelper

	def avg_track_rating(tracks)

		number_with_precision(tracks.average(:author_rating), :precision => 2)
	end

	def get_album_text(artistName, albumName)

		artistName + ' - '+albumName
	end
end
