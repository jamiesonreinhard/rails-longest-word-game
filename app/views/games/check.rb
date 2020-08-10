require 'open-uri'
require 'json'

attempt = JSON.parse(open("https://wagon-dictionary.herokuapp.com/hello").read)
return attempt["found"]