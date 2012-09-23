((context, $, undef) ->

  # window.create_product_images = (result) ->
  #   images = result.detailImages

  #     for  image in images
  #       image.

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
      # mainImage: result.skus.images.900
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
    console.log products

    $container = $("#grid")
    $container.isotope itemSelector: ".element"
 
  $ context.init
) window.BCApp = window.BCApp or {}, jQuery, `undefined`

jQuery ->
  if localStorage.query == undefined
    toogle_admin()