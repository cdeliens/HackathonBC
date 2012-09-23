((context, $, undef) ->



  context.initApp = ->
    context.getProducts()
    context.initFilters()

  
  context.clickElementsHandler = ->
    $("#grid .element").on "click", (event) ->
      sku = $(this).data("sku")
      window.BCApp.getProduct sku

  context.templateLoader = (id, obj) ->
    template_id = $(id)
    source   = template_id.html()
    template = Handlebars.compile(source)
    html = template(obj)

  context.createProductObject = (result) ->
    {
      title:  result.title
      fullDescription: result.fullDescription
      brandImage: result.brandImage
      productGroup: result.productGroup
      bottomLine: result.bottomLine
    }


  context.appendToDetail = (el) ->
    $("#420block").fadeOut()
    detail = $("#detail")
    detail.empty()
    detail.fadeIn "slow", ->
      $(this).append(el)

  context.handleProduct = (json) ->
    productObj = context.createProductObject json
    html = context.templateLoader "#detail-template", productObj
    context.appendToDetail(html)

    featuresHTML = ''
    for feature in json.features
      featuresHTML+= context.templateLoader("#detail-feature-template", feature)
    
    imagesHTML = ''
    for obj in json.detailImages
      obj.nov = obj["900Url"]
      delete obj["900Url"]
      imagesHTML+= context.templateLoader("#detail-image-slide-template", obj)

    $("#detail #features").html( featuresHTML )
    $("#detail #slideshow").html( imagesHTML )
    cycleProducts($("#detail #slideshow"))
    window.detail_binds



  context.getProducts =  ->
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
      $grid.isotope (itemSelector: ".element"), context.clickElementsHandler
 

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
  


