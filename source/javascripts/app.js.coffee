((context, $, undef) ->

  context.initApp = ->
    context.getProducts()

    #listen to tab event on img
    $("#detail-subnav > a").live "click",  ->
      console.log "img click"
      $this = $(@)
      if $(this).is("#showMask")
        $("#transparency").fadeIn "fast"
        $("#comments").slideUp 200, ->
             $("#mask").slideDown 300
      else
        if $(this).is("#showComments")
          $("#transparency").fadeIn "fast"
          $("#mask").slideUp 200, ->
             $("#comments").slideDown 300
        else
          $("#mask, #comments").slideUp 200
          $("#transparency").fadeOut 300
          
      
     

  context.eightamhack =  ->
    json = JSON.parse( localStorage.jsonResult )
    console.dir json

    featuresHTML = ''
    for feature in json.features
      featuresHTML+= context.templateLoader("#detail-feature-template", feature)
    imagesHTML = '' 
    if !$.isEmptyObject(json.detailImages)  && !(json.detailImages[0]["900Url"] == "")
      for obj in json.detailImages
        obj.nov = obj["900Url"] or ""
        delete obj["900Url"]
        imagesHTML+= context.templateLoader("#detail-image-slide-template", obj)
    else
        imagesHTML+= context.templateLoader("#detail-image-slide-template", {nov: "/images/404.png"})

    $("#detail #features").html( featuresHTML )
    $("#detail #slideshow > ul").html( imagesHTML )
    window.mySwipe = new Swipe(document.getElementById('slideshow'));

  context.clickElementsHandler = ->
    console.log "hola"
    $("#grid .element").on "click", (event) ->
      sku = $(this).data("sku")
      context.getProduct sku

    #back button functinality
    $("#back a").live "click", (event) ->
      $("#detail").fadeOut("fast").empty()
      $("#420block").fadeIn("fast")
      $(this).unbind('click')

  context.templateLoader = (id, obj) ->
    template_id = $(id)
    source   = template_id.html()
    template = Handlebars.compile(source)
    html = template(obj)

  context.appendToDetail = (el) ->
    $("#420block").fadeOut(300)
    detail = $("#detail")
    detail.fadeIn 300, ->
      $(@).html(el)
      context.eightamhack()

  context.handleProduct = (json) ->
    html = context.templateLoader "#detail-template", json
    context.appendToDetail(html)
    localStorage.jsonResult = JSON.stringify(json)

  context.getProducts =  ->
    $.ajax
      url: window.searchUrl
      type: "GET"
      dataType: "jsonp"
      error: (xhr, status, error) ->
        console.error error
      success: (json) ->
        console.log json
        context.populateGrid json.posts

  context.getProduct = (id) ->
    $.ajax
      url: window.getProductUrl + id
      type: "GET"
      dataType: "jsonp"
      error: (xhr, status, error) ->
        console.error error
      success: (json) ->
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
      console.log @
      brands[''+@brand] = {"brand": @brand, "brandName": @brandName}
      itemsHTML += itemTemplate(@)

    context.$grid = $grid = $("#grid")
    $grid.html itemsHTML
    #console.log itemsHTML
    $grid.imagesLoaded ->

      $grid.isotope (itemSelector: ".element"),  ->
        #context.clickElementsHandler
        $("#grid .element").on "click", (event) ->
          sku = $(this).data("sku")
          context.getProduct sku

        #back button functinality
        $("#back a").live "click", (event) ->
          $("#detail").fadeOut("fast").empty()
          $("#420block").fadeIn("fast")
          $(this).unbind('click')
    
        $grid.find(".element").each ->
          $(@).addClass($(@).data("category")).fadeIn 300


    context.initFilters brands


  context.initFilters = ( brands ) ->

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
      $filterCategories.filter(".active").not(this).removeClass("active")
      $(this).parent().addClass("active")
      context.$grid.isotope filter: selector
      
      

  $ context.initApp
) window.BCApp = window.BCApp or {}, jQuery, undefined

window.updateLayout = ->
  if window.innerWidth < 1250
    if(window.innerHeight > window.innerWidth)
      $("#main-block").hide()
      $("#admin").slideDown("slow")
    else
      $("#main-block").show()
      $("#admin").hide()

jQuery ->
  setInterval(window.updateLayout, 400);
  


