class AlbumsController < ApplicationController

 	before_action :set_album, only: [:show, :edit, :update, :destroy]

	impressionist :actions=>[:show]

  	respond_to :html

	def index
		@albums = Album.all
	end

	def show
		@album = Album.find(params[:id])
		impressionist(@album)
		@mostReadAlbums = Album.joins(:impressions).group("impressions.impressionable_id").order("count(impressions.id) DESC").limit(10)
	end

	def new
	    @album = Album.new
	    respond_with(@album)
  	end

	def create
	    @album = Album.new(album_params)
	    @album.save
	    respond_with(@album)
	end

  	private
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:title, :album_art, :artist_id, :original_filename, :content_type)
    end
end
