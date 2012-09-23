jQuery ->
  window.query = localStorage.query
  window.searchUrl ="http://hackathon.backcountry.com/hackathon/public/search?q=%22#{query}%22"
  window.getProductUrl = "http://hackathon.backcountry.com/hackathon/public/product/"