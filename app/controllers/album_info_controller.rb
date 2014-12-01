class AlbumInfoController < ApplicationController

	include Wicked::Wizard

	steps :enter_basic_info, :select_musicbrainz_id, :rate_tracks

	def show
		case step
		when :enter_basic_info
	    	
	    end
	    render_wizard @album
	end
end