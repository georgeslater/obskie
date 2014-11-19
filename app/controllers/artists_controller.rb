class ArtistsController < ApplicationController

	def show
		@artist = Artist.friendly.find(params[:id])
	end

	def index
		@artists = Artist.all
	end
end
