
window.cycleProducts = (e) ->
  $(e).cycle
    fx: "scrollLeft"
    speed: 200
    timeout: 0
    next:   '#next' 
    prev:   '#prev'
    pager:  '.pager'
    pagerEvent: "click"

