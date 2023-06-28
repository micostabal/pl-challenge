require 'io/console'
require_relative "client"
require_relative "cli"
require_relative "loader"
require_relative "domain"
require_relative "util"

ARTISTS_FILE = "./artists.json"
CREDENTIALS_FILE = "./credentials.json"

artists_data = open_json_file(ARTISTS_FILE)

cli = CLI.new()

credentials = cli.get_credentials(CREDENTIALS_FILE)

client = SpotifyClient.new(
  credentials[:client_id],
  credentials[:client_secret]
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