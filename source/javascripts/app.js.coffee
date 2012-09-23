((context, $, undef) ->

  # window.create_product_images = (result) ->
  #   images = result.detailImages

  #     for  image in images
  #       image.
  
  window.template_loader = (id, obj) ->
    template_id = $(id)
    source   = template_id.html()
    template = Handlebars.compile(source)
    html = template(obj)

  window.create_product_object = (result) ->
      product = {
        title:  result.title
        full_description : result.fullDescription
        brand_image : result.brandImage
        price: result.skus.listPrice
        sale_price: result.skus.salePrice
        size: result.skus.size
        color: result.skus.color
        productGroup: result.productGroup
        bottomLine: result.bottomLine
       # main_image: result.skus.images.900
      }
      template_loader obj
      obj = $.extend(text, author, media);
      template_loader obj

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
        #console.dir json
        context.populateGrid json.products
  
  context.getProduct = (id) ->
    $.ajax
      url: window.getProductUrl + id
      type: "GET"
      dataType: "jsonp"
      error: (xhr, status, error) ->
        console.error error
      success: (json) ->
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
    #console.log itemsHTML
    $grid.imagesLoaded ->
      $grid.isotope itemSelector: ".element"
 
  $ context.getProducts
) window.BCApp = window.BCApp or {}, jQuery, `undefined`

jQuery ->
  if localStorage.query == undefined
    toogle_admin()