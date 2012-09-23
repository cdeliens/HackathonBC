jQuery ->
  window.query = localStorage.query
  window.search_url ="http://hackathon.backcountry.com/hackathon/public/search?q=%22#{query}%22"