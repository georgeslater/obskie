class RatingsController < ApplicationController

	respond_to :html

	def create

		rating = Rating.new
		rating.score = params[:score]
		rating.track_id = params[:track]
		rating.ip_address = request.remote_ip
		rating.save

		render :ratings
	 end
end 