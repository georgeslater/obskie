class Album < ActiveRecord::Base
	
	belongs_to :artist
	belongs_to :user
	has_many :tracks

	attr_accessor :artist_name

	before_save :get_spotify_info

	is_impressionable # :counter_cache => true

	require 'rspotify'

	require 'openssl'
	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

	has_attached_file :album_art, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"
  	validates_attachment_content_type :album_art, :content_type => /\Aimage\/.*\Z/
  	validates_presence_of :user_id, presence: true
  	validates_presence_of :artist_id, presence: true

  	def get_spotify_info
  		
  		albums = RSpotify::Album.search(self.title)
  		artist = self.artist_name

  		for album in albums
  			if album.artists[0].name == artist

  				image = album.images.first
     			self.album_art = image['url']
     			self.spotify_identifier = album.id
  				break;
  			end
  		end
  	end
end
