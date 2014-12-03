class AlbumsController < ApplicationController

 	before_action :set_album, only: [:show, :edit, :update, :destroy]
 	before_action :authenticate_user!, only: [:create]

	impressionist :actions=>[:show]

  	respond_to :html

	def index

		order = params[:order]

		case order
		when 'Newest first'

			@albums = Album.where('published = true and approved = true').order('created_at DESC')
		
		when 'Oldest first'

			@albums = Album.where('published = true and approved = true').order('created_at ASC')
		
		when 'Album name'

			@albums = Album.where('published = true and approved = true').order('title ASC')

		when 'Artist name'

			@albums = Album.joins(:artist).where('published = true and approved = true').order('artists.name ASC')

		when 'Year'

			@albums = Album.where('published = true and approved = true').order('year ASC')
		
		when 'Most Obscure'

			@albums = Album.where('published = true and approved = true').order('obscurity_rating DESC')

		else

			@albums = Album.where('published = true and approved = true').order('created_at DESC')
		end

		respond_with(@albums)

	end

	def show
		@album = Album.friendly.find(params[:id])
		impressionist(@album)
		@mostReadAlbums = Album.where("impressions_count > 0 and published = true and approved = true").order("impressions_count DESC").limit(20)
		@mostCommentedAlbums = Album.where("comments_count > 0 and published = true and approved = true").order("comments_count DESC").limit(20)

		@relatedAlbums = Array.new
		c = Album.where("published = true and approved = true").count

		until @relatedAlbums.size == 3 || @relatedAlbums.size == c do 

			relAlbum = Album.offset(rand(c)).first

			unless @relatedAlbums.include?(relAlbum) || relAlbum == @album
				@relatedAlbums.push(relAlbum)
			end
		end

		@albumTracks = @album.tracks.order('tracks.order')

		@country = request.location.country_code
	end

	def new_step2
	    
	    @album = @Album.new
  	end

	def edit

		@album = Album.friendly.find(params[:id])
 
	end

	def update

		Rails.logger.debug('YEEEE')
		Rails.logger.debug(params[:type])

		if @album.tracks.select { | track | track.author_rating == nil }.size == 0

			if params[:type] == 'publish'

				redirect_to root_path
				@album.update(album_params.merge(:published => true))
			else
				redirect_to my_drafts_path(current_user)
				@album.update(album_params)
			end
	    end

	end

	def destroy
	    @track.destroy
	    respond_with(@track)
	  end

	def rate_track

		track = Track.find(params[:id])

		rating = params[:score]

		if rating >= 0 && rating <= 5
			track.author_rating = params[:score]
			track.save

			render :nothing => true
		end
	end

  	private
    def set_album
      @album = Album.friendly.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:order, :title, :artist_id, :original_filename, :content_type, :body, :artist_name, :year, :sync_with_spotify)
    end
end
