jQuery ->

  window.toogleAdmin = ->
    $("#main-block").toggle()
    $("#admin").toggle()


  key 'ctrl+q', ->
    localStorage.clear()
    window.location.href = "/"

  key 'ctrl+alt+a', ->
    $("#main-block").hide()
    $("#admin").slideDown("slow")
  key 'ctrl+alt+c', ->
    $("#main-block").show()
    $("#admin").hide()

  $("#clean").on "click", (event) ->
    localStorage.clear()
  $("#query-submit").on "click", (event) ->
    query = $("#query").val()
    localStorage.query = query
    $("#admin #saved-query p").html(localStorage.query)
    window.location.href = "/"
