class Album < ActiveRecord::Base
	
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :artist
  validates_uniqueness_of :title, :scope => :artist

	belongs_to :artist
	belongs_to :user
	has_many :tracks, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all

  after_destroy :release_parent

  def release_parent
    if artist.albums.count.zero?
      artist.destroy
    end
  end

	attr_accessor :artist_name

  is_impressionable :counter_cache => true

	require 'openssl'

  	validates_presence_of :user_id, presence: true
  	validates_presence_of :artist_id, presence: true
end
