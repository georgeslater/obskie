class AlbumsController < ApplicationController

 	before_action :set_album, only: [:show, :edit, :update, :destroy]
 	before_action :authenticate_user!, only: [:create]
 	load_and_authorize_resource :find_by => :slug

 	before_filter :check_published_approved, only: [:show]

  	respond_to :html

	def index
		
		order = params[:order]

		case order
		when 'Newest first'

			@albums = Album.where("workflow_state = 'accepted'").order('created_at DESC')
		
		when 'Oldest first'

			@albums = Album.where("workflow_state = 'accepted'").order('created_at ASC')
		
		when 'Album name'

			@albums = Album.where("workflow_state = 'accepted'").order('title ASC')

		when 'Artist name'

			@albums = Album.joins(:artist).where("workflow_state = 'accepted'").order('artists.name ASC')

		when 'Year'

			@albums = Album.where("workflow_state = 'accepted'").order('year ASC')
		
		when 'Most Obscure'

			@albums = Album.where("workflow_state = 'accepted' and obscurity_rating IS NOT NULL").order('obscurity_rating DESC')

		else

			@albums = Album.where("workflow_state = 'accepted'").order('created_at DESC')
		end

		Rails.logger.debug("%%% "+@albums.to_yaml)

		respond_with(@albums)

	end

	def show
		@album = Album.friendly.find(params[:id])
		impressionist(@album)
		@mostReadAlbums = Album.where("impressions_count > 0 and workflow_state = 'accepted'").order("impressions_count DESC").limit(20)
		@mostCommentedAlbums = Album.where("comments_count > 0 and workflow_state = 'accepted'").order("comments_count DESC").limit(20)

		@relatedAlbums = Array.new
		c = Album.where("workflow_state = 'accepted'").count

		until @relatedAlbums.size == 3 || @relatedAlbums.size >= c-1 do 

			relAlbum = Album.where("workflow_state = 'accepted'").offset(rand(c)).first

			unless @relatedAlbums.include?(relAlbum) || relAlbum == @album
				@relatedAlbums.push(relAlbum)
			end
		end

		@albumTracks = @album.tracks.order('tracks.order')
	end

	def approval

		if current_user.try(:admin?)
			@nonApproved = Album.where("workflow_state = 'awaiting_review'")
		end
	end

	def approve

		if current_user.try(:admin?)
			album = Album.friendly.find(params[:id])
			album.accept!
			redirect_to non_approved_path
		end
	end

	def reject

		if current_user.try(:admin?)
			album = Album.friendly.find(params[:id])
			album.reject!
			album.update({published: false})
			redirect_to non_approved_path
		end
	end

	def check_published_approved

		album = Album.friendly.find(params[:id])

		if album.workflow_state != 'accepted'

			redirect_to root_path
		end
	end

	def edit

		@album = Album.friendly.find(params[:id])
		@albumTracks = @album.tracks.order('tracks.order')
	end

	def update

		Rails.logger.debug('YEEEE')
		Rails.logger.debug(params[:type])

		if params[:type] == 'publish'

			if @album.tracks.select { | track | track.author_rating == nil }.size == 0

				@album.update(album_params.merge(:published => true))
				@album.submit!
			end

			redirect_to root_path

		else
			redirect_to my_drafts_path(current_user)
			@album.update(album_params)
		end
	end

	def destroy
		
		if @album.user == current_user && @album.workflow_state != 'accepted'
	    	@album.destroy!
	    end

	    redirect_to my_drafts_path(current_user)

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
