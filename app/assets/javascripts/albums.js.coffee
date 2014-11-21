getRandomArbitary = (min, max) ->
  (Math.random() * (max - min) + min).toFixed 2
$(document).ready ->
  $("#mostList a").click (e) ->
    e.preventDefault()
    $(this).tab "show"

  $(".ratyTest").each (event, ui) ->
    
      score = $(this).data('score')
      scoreText = (score? score: '')+($(this).data('votes')? '('+$(this).data('votes')+' votes)': '')
      $(this).raty
        score: score
        path: "/assets"
        readOnly: ->
          $(this).hasClass "author"

        hints: [ scoreText, scoreText, scoreText, scoreText, scoreText ]
        click: (score, event) ->
          valText = score
          $(this).raty
            readOnly: true
            score: score
            path: "/assets"
            halfShow: true
            targetType: "score"
            targetKeep: true
            hints: [ valText, valText, valText, valText, valText ]
            $.ajax
              type: 'POST'
              url: '/ratings'
              data: score: score, track: $(this).data('trackid')

          false



$("#menuContent").on "show.bs.collapse", ->
  $(".socialMediaLinks").hide()

$("#menuContent").on "shown.bs.collapse", ->
  $(".socialMediaLinks").show()

$("#menuContent").on "hide.bs.collapse", ->
  $(".socialMediaLinks").hide()

$("#menuContent").on "hidden.bs.collapse", ->
  $(".socialMediaLinks").show()

$(window).load ->
  $("#shareBtns").css "display", "block"
  return

((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  return  if d.getElementById(id)
  js = d.createElement(s)
  js.id = id
  js.src = "//connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v2.0"
  fjs.parentNode.insertBefore js, fjs
  return
) document, "script", "facebook-jssdk"
