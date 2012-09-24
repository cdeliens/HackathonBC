jQuery ->
  window.query = localStorage.query
  window.searchUrl ="http://api.backcountry.com/public/search?q=%22#{query}%22"
  window.getProductUrl = "http://api.backcountry.com/public/product/"