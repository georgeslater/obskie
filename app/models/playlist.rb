class Playlist < ActiveRecord::Base
	extend FriendlyId

	belongs_to :user
	has_many :comments

	friendly_id :name, use: :slugged

	validates_format_of :spotify_uri, :with => /\Aspotify:(user:[^:]+:playlist):([a-zA-Z0-9]+)\z/, :on => :create, :allow_nil => true, :allow_blank => true

end
