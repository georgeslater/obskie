class Album < ActiveRecord::Base
	
	belongs_to :artist
	belongs_to :user
	has_many :tracks

	attr_accessor :artist_name

	before_save :get_album_art

	is_impressionable # :counter_cache => true

	require 'rspotify'

	require 'openssl'
	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

	has_attached_file :album_art, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"
  	validates_attachment_content_type :album_art, :content_type => /\Aimage\/.*\Z/
  	validates_presence_of :user_id, presence: true
  	validates_presence_of :artist_id, presence: true

  	def get_album_art
  		
  		artist = RSpotify::Artist.search(self.artist_name).first
  		
		i = 0
		albumCount = artist.albums.length

		album_id = nil

		while i < albumCount do
				
			if artist.albums[i].name == self.title

				album_id = artist.albums[i].id
			end

			i += 1
		end
			
		if album_id.present?

	  		album = RSpotify::Album.find(album_id)
	    	image = album.images.first
	    	self.album_art = image['url']
	 	end
  	end
end
