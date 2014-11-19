class Album < ActiveRecord::Base
	
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :artist

	belongs_to :artist
	belongs_to :user
	has_many :tracks

	attr_accessor :artist_name

	after_save :get_spotify_info

	is_impressionable # :counter_cache => true

	require 'openssl'
	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

	has_attached_file :album_art, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"
  	validates_attachment_content_type :album_art, :content_type => /\Aimage\/.*\Z/
  	validates_presence_of :user_id, presence: true
  	validates_presence_of :artist_id, presence: true

  	def get_spotify_info
  		  
        #if self.spotify_identifier == nil

  		   # SpotifyAlbumInfoJob.new.async.perform(self)
        #end

        albums = RSpotify::Album.search(self.title)
        artist = self.artist_name

        for album in albums
          if album.artists[0].name == artist

            image = album.images[1]

            self.album_art = image['url']
            self.spotify_identifier = album.id
            if album.release_date_precision == 'year'
              self.year = album.release_date
            end

            tracks = Array.new

            for track in album.tracks

              new_track = Track.new
              new_track.name = track.name
              new_track.album_id = self.artist_id
              new_track.order = track.disc_number * track.track_number
              tracks.push(new_track.as_json)
            end

            Rails.logger.debug "This is my tracks!"
            Rails.logger.debug tracks.inspect
            Rails.logger.debug "This is self!"
            Rails.logger.debug self
            Track.create(tracks)

            break;
          end
        end
  	end
end
