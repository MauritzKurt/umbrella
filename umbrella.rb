pp "Where are you located?"

user_location = gets.chomp.gsub(" ","%20")
# user_location = "chicago"


pp user_location

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

# p maps_url
require "http"

resp = HTTP.get(maps_url)

raw_response = resp.to_s

require "json"

parsed_response = JSON.parse(raw_response)

results = parsed_response.fetch("results")

first_result = results.at(0)

geo = first_result.fetch("geometry")
loc = geo.fetch("location")


pp latitude = loc.fetch("lat")
pp longitude = loc.fetch("lng")



# require "http"

# pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

# pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887, -87.6355"

# raw_response = HTTP.get(pirate_weather_url)

# require "json"

# parsed_response = JSON.parse(raw_response)

# currently_hash = parsed_response.fetch("currently")

# current_temp = currently_hash.fetch("temperature")

# puts "The current temperature is " + current_temp.to_s + "."
