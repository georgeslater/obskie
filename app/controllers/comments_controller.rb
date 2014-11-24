class CommentsController < ApplicationController

 	before_action :authenticate_user!, only: [:create]

	def create
		@album = Album.friendly.find(params[:album_id])
		@artist = Artist.friendly.find(@album.artist_id)
	    @comment = @album.comments.create(comment_params.merge(:user_id => current_user.id))
	    redirect_to artist_album_path(@artist, @album)
  	end
 
  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
