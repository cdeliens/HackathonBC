Handlebars.registerHelper "image_tag", (object) ->
  new Handlebars.SafeString("<img src='" + object + "'/>")
