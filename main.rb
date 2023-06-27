require_relative "client"
require_relative "loader"
require_relative "domain"

ARTISTS_FILE = "./artists.json"
CREDENTIALS_FILE = "./credentials.json"

artists_file = File.open ARTISTS_FILE

artists_data = JSON.load artists_file

if File.file?(CREDENTIALS_FILE)
  credentials_file = File.open CREDENTIALS_FILE
  auth_data = JSON.load credentials_file
  
  client_id = auth_data['client_id']
  client_secret = auth_data['client_secret']
else 
  puts "Enter client_id"
  client_id = gets.chomp
  puts "Enter client_secret"
  client_secret = gets.chomp
end

client = SpotifyClient.new(
  client_id,
  client_secret
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