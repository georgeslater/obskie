class AlbumsController < ApplicationController

 	before_action :set_album, only: [:show, :edit, :update, :destroy]

	impressionist :actions=>[:show]

  	respond_to :html

	def index
		@albums = Album.all.order("created_at DESC")
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
	    @album.user_id = current_user.id

	    name = params[:album][:artist_name]


	    album_artist = Artist.find_by(name: name)

	    if album_artist.blank?

	    	album_artist = Artist.new
	    	album_artist.name = name
	    	album_artist.save
	    end

	    @album.artist_id = album_artist.id

	    @album.save
	    
	    respond_with(@album)
	end

  	private
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:title, :album_art, :artist_id, :original_filename, :content_type, :body, :artist_name)
    end
end
