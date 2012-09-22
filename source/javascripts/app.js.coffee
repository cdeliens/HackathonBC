jQuery ->


  window.get_products = ->
    $.getJSON("#{window.search_url}",
      (products) ->
        console.log products
    ).success(->
      alert "success fetch"
    ).error(->
      alert "Error fetch")

  if localStorage.query == undefined
    toogle_admin()