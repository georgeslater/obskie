class ArtistsController < ApplicationController

	def index
		@artists = Artist.all.order('name ASC')
	end
end
