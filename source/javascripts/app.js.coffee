((context, $, undef) ->

  context.appendToDetail = (el) ->
    detail = $("#detail")
    detail.empty()
    detail.append(el)

  context.getProducts = ->
    $.ajax
      url: window.searchUrl
      type: "GET"
      dataType: "jsonp"
      error: (xhr, status, error) ->
        console.error error
      success: (json) ->
        console.dir json
  
  context.getProduct = (id) ->
    $.ajax
      url: window.getProductUrl + id
      type: "GET"
      dataType: "jsonp"
      error: (xhr, status, error) ->
        console.error error
      success: (json) ->
        console.dir json

  context.populateGrid = (products) ->
    console.log products

    $container = $("#grid")
    $container.isotope itemSelector: ".element"
 
  $ context.init
) window.BCApp = window.BCApp or {}, jQuery, `undefined`

jQuery ->
  if localStorage.query == undefined
    toogle_admin()