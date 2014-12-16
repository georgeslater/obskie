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

	 $('#spotifyToggle, #deezerToggle').click ->

		$(".playlistItem").show().each ->
		  console.log($("#spotifyToggle").is(":checked"))
		  console.log($(this).hasClass("spotifyPlaylist"))
		  console.log($("#deezerToggle").is(":checked"))
		  console.log($(this).hasClass("deezerPlaylist"))
		  console.log('ohhh')
		  $(this).hide()  if not $("#spotifyToggle").is(":checked") and $(this).hasClass("spotifyPlaylist") and (not $("#deezerToggle").is(":checked") or not $(this).hasClass("deezerPlaylist"))
		  $(this).hide()  if not $("#deezerToggle").is(":checked") and $(this).hasClass("deezerPlaylist") and (not $("#spotifyToggle").is(":checked") or not $(this).hasClass("spotifyPlaylist"))
		  return



	 	
