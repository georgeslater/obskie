class AmazonAlbumInfoJob < ApplicationController
	include SuckerPunch::Job

	def requestAlbumLink(locale, assoc_tag, album_created)

		req = Vacuum.new(locale)

		req.configure(
			aws_access_key_id: ENV['AMAZON_ACCESS_KEY_ID'],
			aws_secret_access_key: ENV['AMAZON_SECRET_KEY'],
			associate_tag: assoc_tag
		)

		params = {

			'SearchIndex' => 'Music',
			'Artist' => album_created.artist.name,
			'Title' => album_created.title
		}

		res = req.item_search(query: params).to_h

		url = res['ItemSearchResponse']['Items']['Item'][0]['DetailPageURL']

		url

	end

	def perform(album_created)

		amazon_url_us = requestAlbumLink('US', 'obscalbu-20', album_created)
		amazon_url_uk = requestAlbumLink('GB', 'obscalbu-21', album_created)

		album_created.update_attributes(amazon_url: amazon_url_us, amazon_url_uk: amazon_url_uk)
	end
end