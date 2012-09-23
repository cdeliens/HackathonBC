((context, $, undef) ->

  # window.create_product_images = (result) ->
  #   images = result.detailImages

  #     for  image in images
  #       image.

  context.initApp = ->
    context.getProducts()

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
        #console.dir json
        context.handleProduct json


  context.populateGrid = (products) ->
    #console.log products

    #init templates
    itemSource = $("#item-template").html()
    itemTemplate = Handlebars.compile( itemSource )

    filterSource = $("#filter-template").html()
    filterTemplate = Handlebars.compile( filterSource )

    #generate items html, filters html and populate the grid
    itemsHTML = ""
    filtersHTML = ""
    brands = {}

    $.each products, ->
      #console.log this
      brands[''+@brand] = {"brand": @brand, "brandName": @brandName}
      itemsHTML += itemTemplate(@)

    $grid = $("#grid")
    $grid.html itemsHTML
    #console.log itemsHTML
    $grid.imagesLoaded ->
      $grid.isotope itemSelector: ".element"

    context.initFilters brands

 
  context.initFilters = ( brands ) ->
    console.log "initFilters"

   # console.dir brands

    #init templates
    filterSource = $("#filter-template").html()
    filterTemplate = Handlebars.compile( filterSource )

    #filters html
    filtersHTML = ""

    $.each brands, ->
      #console.log this
      filtersHTML += filterTemplate(@)

    $("#filters > ul ").append( filtersHTML )

    $filterCategories =  $("#filters  > ul > li")
    $filterCategories.on "click", (event) ->
      $filterCategories.filter(".active").not(this).removeClass("active").find("ul").slideUp()
      $(this).addClass("active").find("ul").slideDown()  

  $ context.initApp
) window.BCApp = window.BCApp or {}, jQuery, undefined

jQuery ->
  if localStorage.query == undefined
    toogle_admin()