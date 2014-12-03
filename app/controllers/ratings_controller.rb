class RatingsController < ApplicationController

	respond_to :html

	def create

		track = Track.find(params[:track])

		rating = params[:score].to_f

		if rating >= 0 && rating <= 5
			track.update_attributes(author_rating: rating)
		end

		render :nothing => true
	 end
end 