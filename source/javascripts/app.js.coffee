((context, $, undef) ->

  # window.create_product_images = (result) ->
  #   images = result.detailImages

  #     for  image in images
  #       image.

  context.initApp = ->
    context.getProducts()
    context.initFilters()

  context.templateLoader = (id, obj) ->
    template_id = $(id)
    source   = template_id.html()
    template = Handlebars.compile(source)
    html = template(obj)

  context.createProductObject = (result) ->
    {
      title:  result.title
      fullDescription: result.fullDescription
      brand_image: result.brandImage
      price: result.skus.listPrice
      sale_price: result.skus.salePrice
      size: result.skus.size
      color: result.skus.color
      productGroup: result.productGroup
      bottomLine: result.bottomLine
      mainImage: result.skus.images["900"]
      }
      

  context.appendToDetail = (el) ->
    detail = $("#detail")
    detail.empty()
    detail.append(el)

  context.handleProduct = (json) ->
    productObj = context.createProductObject json
    html = context.templateLoader "#detail-template", productObj
    context.appendToDetail(html)

  context.getProducts = ->
    console.log "get products"
    $.ajax
      url: window.searchUrl
      type: "GET"
      dataType: "jsonp"
      error: (xhr, status, error) ->
        console.error error
      success: (json) ->
        console.dir json
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
        console.dir json
        context.handleProduct json


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
 
  context.initFilters = ->
    $filterCategories =  $("#filters  > ul > li")
    $filterCategories.on "click", (event) ->
      $filterCategories.filter(".active").not(this).removeClass("active").find("ul").slideUp(500)
      $(this).addClass("active").find("ul").slideDown(500)  

  $ context.initApp
) window.BCApp = window.BCApp or {}, jQuery, undefined

jQuery ->
  if localStorage.query == undefined
    toogle_admin()