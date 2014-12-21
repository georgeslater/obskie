class UsersController < ApplicationController

	def show
		
		@user = User.friendly.find(params[:id])
		@userAlbums = @user.albums.order('created_at DESC')
		@userComments = @user.comments.order('created_at DESC')
		@userPlaylists = @user.playlists.order('created_at DESC')
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
end