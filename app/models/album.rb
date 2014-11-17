class Album < ActiveRecord::Base
	belongs_to :artist
	belongs_to :user
	has_many :tracks

	is_impressionable # :counter_cache => true

	has_attached_file :album_art, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :album_art, :content_type => /\Aimage\/.*\Z/
  	validates_presence_of :user_id, presence: true
  	validates_presence_of :artist_id, presence: true
end
