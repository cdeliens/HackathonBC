Handlebars.registerHelper "image_tag", (object) ->
  new Handlebars.SafeString("<img src='" + object + "'/>")

Handlebars.registerHelper "css_class", (object) ->
  new Handlebars.SafeString(object)
