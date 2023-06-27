require_relative "SpotifyClient"

artist_id = "4gzpq5DPGxSnKTe4SA8HAU"
market = "CL"

file = File.open "./credentials.json"

data = JSON.load file

client = SpotifyClient.new(
  data['client_id'],
  data['client_secret']
)

client.authenticate()

artist_response = client.get_artist(artist_id)

puts artist_response
