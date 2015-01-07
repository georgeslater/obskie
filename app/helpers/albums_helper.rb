module AlbumsHelper

	def avg_track_rating(tracks)

		number_with_precision(tracks.average(:author_rating), :precision => 2)
	end

	def get_album_text(artistName, albumName)

		artistName + ' - '+albumName
	end

	def get_state_label(state)

		if state
			Album.workflow_spec.states[state.to_sym].meta[:label]
		end
	end

	def truncate_album_body(body)

		if body && body.size > 30

			body[0..30]+"..."
		else
			body
		end
	end

	def get_title_text(album)

		res = album.artist.name + ' - '+album.title

		if album.year.present?

			res += ' ('+album.year.to_s+')'
		end

		res
	end

	def get_meta_keywords(album)

		album_year = if album.year.present? then album.year.to_s+", " else "" end
		album.artist.name+', '+album.title+', '+album_year+'obscure albums, forgotten albums, lost classics, album reviews, music reviews'
	end

	def get_meta_description(album)

		if album.body && album.body.size > 155

			album.body[0..155]+"..."

		else
			album.body
		end
	end
end
