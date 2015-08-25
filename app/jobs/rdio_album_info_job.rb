class RdioAlbumInfoJob < ApplicationController
	include SuckerPunch::Job

	require 'rubygems'
	require 'rdio'
	
	def perform(album_created)
		
		unless album_created.upc_barcode.nil? || album_created.upc_barcode.blank?

			rdio = Rdio.new([ENV['RDIO_KEY'], ENV['RDIO_SHARED_SECRET']])
			
			album_results = rdio.call('search', { 'query' => album_created.title+" "+album_created.artist.name, 'never_or' => false, 'count' => 1, 'types' =>  'Album' })

			Rails.logger.debug('^^^^^')
			Rails.logger.debug(album_results.inspect)

			result = album_results['result']['results'][0]

			if result
			
				url = result['url']

				if url.present?

					linkshare_uri = 'http://click.linksynergy.com/fs-bin/click?id=/0gJtLz2nOs&subid=&offerid=341998.1&type=10&tmpid=8599&RD_PARM1='+ERB::Util.url_encode(url)
				end

				key = result['key']
			end		

			if url && linkshare_uri

				album_created.update_attributes({rdio_url: linkshare_uri})

				#Get tracks
				track_response = rdio.call('search', {'query' => album_created.title+" "+album_created.artist.name, 'never_or' => false, 'count' => 200, 'types' => 'Track'})

				track_results = track_response['result']['results']

				for track in album_created.tracks

					for track_result in track_results

						Rails.logger.debug('Comparing !!!!!')
						Rails.logger.debug(url+" ----- "+track.name)
						Rails.logger.debug('with !!!!!')
						Rails.logger.debug(track_result['albumUrl']+" ----- "+track_result['name'])						

						apostrophe_changed_name = track_result['name'].gsub "'", "’"
						Rails.logger.debug('name is')
						Rails.logger.debug(apostrophe_changed_name) 
						if url == track_result['albumUrl'] && track.name.casecmp(apostrophe_changed_name) == 0

							track_url = 'http://www.rdio.com'+track_result['url']
							linkshare_track_url = 'http://click.linksynergy.com/fs-bin/click?id=/0gJtLz2nOs&subid=&offerid=341998.1&type=10&tmpid=8599&RD_PARM1='+ERB::Util.url_encode(track_url)
							track.update_attributes(rdio_url: track_url)
							break
						end
					end
				end

			end
		end
	end

end