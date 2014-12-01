class AlbumsController < ApplicationController

 	before_action :set_album, only: [:show, :edit, :update, :destroy]
 	before_action :authenticate_user!, only: [:create]

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

		when 'Year'

			@albums = Album.all.order('year ASC')
		
		when 'Most Obscure'

			@albums = Album.all.order('obscurity_rating DESC')

		else

			@albums = Album.all.order('created_at DESC')
		end

		respond_with(@albums)

	end

	def show
		@album = Album.friendly.find(params[:id])
		impressionist(@album)
		@mostReadAlbums = Album.where("impressions_count > 0").order("impressions_count DESC").limit(20)
		@mostCommentedAlbums = Album.where("comments_count > 0").order("comments_count DESC").limit(20)

		@relatedAlbums = Array.new
		c = Album.count

		until @relatedAlbums.size == 3 || @relatedAlbums.size == c do 

			relAlbum = Album.offset(rand(c)).first

			unless @relatedAlbums.include?(relAlbum) || relAlbum == @album
				@relatedAlbums.push(relAlbum)
			end
		end

		@albumTracks = @album.tracks.order('tracks.order')

		@country = request.location.country_code
	end

	def new
	    redirect_to album_info_path(:enter_basic_info)
  	end

	def create
	    @album = Album.new(album_params)
	    @album.user_id = current_user.id

	    name = params[:album][:artist_name]
	    sync_with_spotify = params[:sync_with_spotify]

	    logger.debug "Sync? #{sync_with_spotify}"

	    album_artist = Artist.find_by(name: name)

	    if album_artist.blank?

	    	album_artist = Artist.new
	    	album_artist.name = name
	    	album_artist.save
	    end

	    @album.artist_id = album_artist.id

	    @album.save
	    
	   	logger.debug "Album attributes hash: #{@album.attributes.inspect}"

	    if sync_with_spotify == 'Automatic'
			SpotifyAlbumInfoJob.new.perform(@album)
	    end

	    ItunesAlbumInfoJob.new.perform(@album)

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
      params.require(:album).permit(:order, :title, :artist_id, :original_filename, :content_type, :body, :artist_name, :year, :sync_with_spotify)
    end
end
