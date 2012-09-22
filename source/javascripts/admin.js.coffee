jQuery ->

  window.admin_init= ->


  window.toogle_admin = ->
    $("#main-block").toggle()
    $("#admin").toggle()
    # admin_init()


  key 'ctrl+a', ->
    toogle_admin()

  $("#query-submit").on "click", (event) ->
    query = $("#query").val()
    localStorage.query = query
    $("#admin #saved-query p").html(localStorage.query)
    window.location.href = "/"
