# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	
	$("input.playlistTypeCb").click ->
	    
		switch $(this).data('type')
			when 'spotify'
				if $(this).is(':checked')
					$('#spotifySection').show() 
				else 
					$('#spotifySection').hide()
			when 'deezer'
				if $(this).is(':checked')
					$('#deezerSection').show() 
				else 
					$('#deezerSection').hide() 
			when 'rdio'
				if $(this).is(':checked')
					$('#rdioSection').show() 
				else 
					$('#rdioSection').hide()
	    return