class AlbumsController < ApplicationController

 	before_action :set_album, only: [:show, :edit, :update, :destroy]

	impressionist :actions=>[:show]

  	respond_to :html

	def index

		order = params[:order]

		case order
		when 'Newest first'

			@albums = Album.all.order('created_at DESC')
		
		when 'Oldest first'

			@albums = Album.all.order('created_at ASC')
		
		when 'Album name'

			@albums = Album.all.order('title ASC')

		when 'Artist name'

			@albums = Album.joins(:artist).all.order('artists.name ASC')

		else

			@albums = Album.all.order('created_at DESC')
		end

		respond_with(@albums)

	end

	def show
		@album = Album.friendly.find(params[:id])
		impressionist(@album)
		@mostReadAlbums = Album.all.order("impressions_count DESC").limit(10)
		
		@relatedAlbums = Array.new
		c = Album.count

		3.times do 

			@relatedAlbums.push(Album.offset(rand(c)).first)
		end

		@albumTracks = @album.tracks.order('tracks.order')
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
	    
	    respond_with(@album.artist, @album)
	end

	def destroy
	    @track.destroy
	    respond_with(@track)
	  end

  	private
    def set_album
      @album = Album.friendly.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:order, :title, :artist_id, :original_filename, :content_type, :body, :artist_name, :year)
    end
end
