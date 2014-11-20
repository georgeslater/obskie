class Track < ActiveRecord::Base
  belongs_to :album
  has_many :ratings

  def avgUserRating
  	
  	return self.ratings.average('score')
  end

  def formatTime

  	var time = ""

  	if self.duration_milli

  		time += (track.duration_milli / 1000) / 60
  		time += ":"

  		secondsPart = (track.duration_milli / 1000) % 60
  		
  		if secondsPart.length == 0
  			time += '00'
  		elsif secondsPart.length == 1
  			time += '0'
  		end

  		time += secondsPart

  	end

  	return time
  end

end
