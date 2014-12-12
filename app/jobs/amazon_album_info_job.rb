class AmazonAlbumInfoJob < ApplicationController
	include SuckerPunch::Job

	def perform(album_created)

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
 		Rails.logger.debug('heeeere it is!')
 		Rails.logger.debug(res['ItemSearchResponse'])
 		Rails.logger.debug(res['ItemSearchResponse']['Items'])
 		Rails.logger.debug(res['ItemSearchResponse']['Items']['Item'])
 		Rails.logger.debug(res['ItemSearchResponse']['Items']['Item'][0]['DetailPageURL'])

		url = res['ItemSearchResponse']['Items']['Item'][0]['DetailPageURL']
		
		album_created.update_attributes(amazon_url: url)
	end
end