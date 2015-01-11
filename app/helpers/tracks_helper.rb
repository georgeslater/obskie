module TracksHelper

	def formatTime(timeMilli)

	  	time = ""

	  	if timeMilli != nil

	  		time += ((timeMilli / 1000) / 60).to_s
	  		time += ":"

	  		secondsPart = ((timeMilli / 1000) % 60).to_s
	  		
	  		if secondsPart.length == 0
	  			time += '00'
	  		elsif secondsPart.length == 1
	  			time += '0'
	  		end

	  		time += secondsPart

	  	end

	  	return time
  	end

  	def get_schema_duration(timeMilli)

  		time = ""

  		if timeMilli != nil
  		
  			time += "PT" + ((timeMilli / 1000) / 60).to_s + "M"

  			secondsPart = ((timeMilli / 1000) % 60).to_s
	  		
	  		if secondsPart.length == 0
	  			time += '00'
	  		elsif secondsPart.length == 1
	  			time += '0'
	  		end

	  		time += secondsPart + "S"
	  	end

	  	return time
  	end
end
