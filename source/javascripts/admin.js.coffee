jQuery ->
  window.admin_init= ->


  window.toogle_admin = ->
    $("#main-block").toggle()
    $("#admin").toggle()
    admin_init()


  key 'ctrl+a', ->
    toogle_admin()