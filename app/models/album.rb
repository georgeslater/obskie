class Album < ActiveRecord::Base
	
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :artist

	belongs_to :artist
	belongs_to :user
	has_many :tracks

	attr_accessor :artist_name
  attr_accessor :sync_with_spotify

	after_save :get_spotify_info

  is_impressionable :counter_cache => true

	require 'openssl'

  	validates_presence_of :user_id, presence: true
  	validates_presence_of :artist_id, presence: true

  	def get_spotify_info
  		
      if self.sync_with_spotify == true 
  		  SpotifyAlbumInfoJob.new.async.perform(self)
      end

    end
end
