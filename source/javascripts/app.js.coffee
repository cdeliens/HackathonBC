((context, $, undef) ->
  context.init = ->
    #load data from API
    $.ajax
      url: "http://hackathon.backcountry.com/hackathon/public/search?q=%22eyewear%22"
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
 
  #initialize on DOM ready
  $ context.init
) window.BCApp = window.BCApp or {}, jQuery, `undefined`
