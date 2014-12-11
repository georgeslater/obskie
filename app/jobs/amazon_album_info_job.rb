class AmazonAlbumInfoJob < ApplicationController
	include SuckerPunch::Job

	def perform(album_created)

		req = Vacuum.new

		req.configure(
			aws_access_key_id: 'AKIAJGOGKCFQO5K2A6XA',
			aws_secret_access_key: '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',
			associate_tag: 'obscalbu-20'
		)

		params = {

			'SearchIndex' => 'Music',
			'Artist' => album_created.artist.name,
			'Title' => album_created.title
		}

		res = req.item_search(query: params).to_h

		Rails.logger.debug(res)
	end
end