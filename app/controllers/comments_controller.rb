class CommentsController < ApplicationController

 	before_action :authenticate_user!, only: [:create]

	def create

		if params[:album_id].present?

			@album = Album.friendly.find(params[:album_id])
			@artist = Artist.friendly.find(@album.artist_id)
		    @comment = @album.comments.create(comment_params.merge(:user_id => current_user.id))
		    redirect_to artist_album_path(@artist, @album)

		elsif params[:playlist_id].present?

			@playlist = Playlist.find(params[:playlist_id])
			@comment = @playlist.comments.create(comment_params.merge(:user_id => current_user.id))
			redirect_to playlist_path(@playlist)

		end
  	end
 
  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
