class AmazonAlbumInfoJob < ApplicationController
	include SuckerPunch::Job

	def perform(album_created)

		begin
			req = Vacuum.new

			req.configure(
				aws_access_key_id: ENV['AMAZON_ACCESS_KEY_ID'],
				aws_secret_access_key: ENV['AMAZON_SECRET_KEY'],
				associate_tag: 'obscalbu-20'
			)

			params = {

				'SearchIndex' => 'Music',
				'Artist' => album_created.artist.name,
				'Title' => album_created.title
			}

			res = req.item_search(query: params).to_h

			url = res['ItemSearchResponse']['Items']['Item'][0]['DetailPageURL']
			
			album_created.update_attributes(amazon_url: url)

		rescue => e

			Rails.logger.warn('Unable to perform this operation: {#e}')
		end
	end
end