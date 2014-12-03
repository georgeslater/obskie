class UsersController < ApplicationController

	def show

		@user = User.friendly.find(params[:id])
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
end