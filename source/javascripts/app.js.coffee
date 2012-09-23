((context, $, undef) ->
  context.getProducts = ->
    $.ajax
      url: window.search_url
      type: "GET"
      dataType: "jsonp"
      error: (xhr, status, error) ->
        console.error error
      success: (json) ->
        #console.dir json
        context.populateGrid json.products

  context.populateGrid = (products) ->
    #console.log products

    #init template
    source = $("#item-template").html()
    template = Handlebars.compile(source)

    #generate items html and populate the grid
    itemsHTML = ""
    $.each products, ->
      itemsHTML += template(this)

    $grid = $("#grid")
    $grid.html itemsHTML
    $grid.imagesLoaded ->
      $grid.isotope itemSelector: ".element"
 
  $ context.getProducts
) window.BCApp = window.BCApp or {}, jQuery, `undefined`

jQuery ->
  if localStorage.query == undefined
    toogle_admin()