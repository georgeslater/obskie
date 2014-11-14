
getRandomArbitary = (min, max) ->
  (Math.random() * (max - min) + min).toFixed 2
$(document).ready ->
  $("#mostList a").click (e) ->
    e.preventDefault()
    $(this).tab "show"

  $(".ratyTest").each (event, ui) ->
    score = getRandomArbitary(0, 5)
    scoreText = score + ((if $(this).hasClass("author") then "" else " (3 votes)"))
    $(this).raty
      score: score
      path: "/assets"
      readOnly: ->
        $(this).hasClass "author"

      hints: [ scoreText, scoreText, scoreText, scoreText, scoreText ]
      click: (score, event) ->
        val = getRandomArbitary(0, 5)
        valText = val + " (4 votes)"
        console.log val
        $(this).raty
          readOnly: true
          score: val
          path: ".assets"
          halfShow: true
          targetType: "score"
          targetKeep: true
          hints: [ valText, valText, valText, valText, valText ]

        false



$("#menuContent").on "show.bs.collapse", ->
  $(".socialMediaLinks").hide()

$("#menuContent").on "shown.bs.collapse", ->
  $(".socialMediaLinks").show()

$("#menuContent").on "hide.bs.collapse", ->
  $(".socialMediaLinks").hide()

$("#menuContent").on "hidden.bs.collapse", ->
  $(".socialMediaLinks").show()
