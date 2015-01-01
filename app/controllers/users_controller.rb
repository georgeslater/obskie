class UsersController < ApplicationController

	def show
		
		@user = User.friendly.find(params[:id])

		if  @user == current_user 

			@userAlbums = @user.albums.order('created_at DESC')
			@userComments = @user.comments.order('created_at DESC')
			@userPlaylists = @user.playlists.order('created_at DESC')
		else

			@userAlbums = @user.albums.order('created_at DESC').select { | album | album.workflow_state == "accepted" }
			@userComments = @user.comments.order('created_at DESC')
			@userPlaylists = @user.playlists.order('created_at DESC')
		end
	end

	def drafts

		@user = User.friendly.find(params[:id])

		if @user == current_user

			@unfinishedAlbums = @user.albums.select { | album | album.published == false }

		else

			redirect_to root_path
		end
	end

	def rateTrack

		render :nothing => true
	end

	def become_contributor

	end

	def sign_up_success

	end
end