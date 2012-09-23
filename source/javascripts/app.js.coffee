((context, $, undef) ->


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
      brandImage: result.brandImage
      productGroup: result.productGroup
      bottomLine: result.bottomLine
    }


  context.appendToDetail = (el) ->
    $("#grid").fadeOut()
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

    context.$grid = $grid = $("#grid")
    $grid.html itemsHTML
    #console.log itemsHTML
    $grid.imagesLoaded ->
      $grid.isotope itemSelector: ".element"
      $grid.find(".element").each ->
        $(@).addClass($(@).data("category"))

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
    $filterCategories.find("> a").on "click", (event) ->
      selector = $(this).attr("data-filter")
      context.$grid.isotope filter: selector
      $filterCategories.filter(".active").not(this).removeClass("active").find("ul").slideUp()
      $(this).parent().addClass("active").find("ul").slideDown()  

  $ context.initApp
) window.BCApp = window.BCApp or {}, jQuery, undefined

jQuery ->
  if localStorage.query == undefined
    toogle_admin()

