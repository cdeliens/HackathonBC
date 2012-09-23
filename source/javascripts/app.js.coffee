((context, $, undef) ->
  context.getProducts = ->
    $.ajax
      url: window.search_url
      type: "GET"
      dataType: "jsonp"
      error: (xhr, status, error) ->
        console.error error
      success: (json) ->
        console.dir json
        context.populateGrid json.products

  context.populateGrid = (products) ->
    console.log products

    $container = $("#grid")
    $container.isotope itemSelector: ".element"
 
  $ context.init
) window.BCApp = window.BCApp or {}, jQuery, `undefined`

jQuery ->
  if localStorage.query == undefined
    toogle_admin()