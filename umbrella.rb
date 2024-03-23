require "http"
require "json"

# opening prompt
pp "Where are you located?"

# user input
user_location = gets.chomp.gsub(" ","%20")

# assembling the url using strings & token keys
maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

# converting the string to a url & storing in a var
resp = HTTP.get(maps_url)

# converting the reponse from the url to a string, then storing in a var
raw_response = resp.to_s

# parsing the response from a string into json
parsed_response = JSON.parse(raw_response)

# starting to dig through the response to reach what we want, results from parsed response
results = parsed_response.fetch("results")

# digging further, first result from results (weird google api thing, array with only 1 object)
first_result = results.at(0)

# digging further, geometry from first result
geo = first_result.fetch("geometry")

# digging further, location from geometry
loc = geo.fetch("location")

# digging further, lat & lng from location (end goal)
latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

# Take the lat/lng
# Assemble the correct URL for the Pirate Weather API
# Get it, parse it, and dig out the current temperature


pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/" + latitude.to_s + "," + longitude.to_s         #"/41.8887, -87.6355"

resp_p = HTTP.get(pirate_weather_url)

raw_response_p = resp_p.to_s

parsed_response_p = JSON.parse(raw_response_p)

currently_hash = parsed_response_p.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature in "+ user_location.capitalize + " is: " + current_temp.to_s + "."
