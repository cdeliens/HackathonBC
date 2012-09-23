
window.cycleProducts = (e) ->
  $(e).cycle
    fx: "scrollLeft"
    speed: 200
    timeout: 0
    next:   '#next' 
    prev:   '#prev'
    pager:  '.pager'
    pagerEvent: "click"

  window.detail_binds = ->
    $("#back a").on "click", (event) ->
      $("#detail").toggle()
      $("#detail").empty()
      $("#420block").fadeIn()

