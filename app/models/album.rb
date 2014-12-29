class Album < ActiveRecord::Base
	include Workflow
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :artist

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

  workflow do

    state :new, :meta => {:label => "Draft"} do
      event :submit, :transitions_to => :awaiting_review
    end
    state :awaiting_review, :meta => {:label => "Review Pending"} do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
    end

    state :accepted, :meta => {:label => "Approved"}
    
    state :rejected, :meta => {:label => "Not Approved"} do
        event :submit, :transitions_to => :awaiting_review
    end
  end

	require 'openssl'

  	validates_presence_of :user_id, presence: true
  	validates_presence_of :artist_id, presence: true
end
