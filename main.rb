require_relative "client"
require_relative "loader"
require_relative "domain"

artists_file = File.open "./artists.json"

artists_data = JSON.load artists_file

credentials_file = File.open "./credentials.json"

auth_data = JSON.load credentials_file

client = SpotifyClient.new(
  auth_data['client_id'],
  auth_data['client_secret']
)

client.authenticate()

loader = Loader.new(client)

artists = []

artists_data.each { |artist_id|
  artist = loader.load_artist_from_id(artist_id)
  artists.push(artist)
}

artists.sort.each { |artist|
  puts artist.summary
}