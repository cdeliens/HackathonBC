jQuery ->
  window.query = localStorage.query
  window.search_url ="http://api.backcountry.com/public/search?q=%22#{query}%22"