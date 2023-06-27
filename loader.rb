require_relative "client"

class Loader
  attr_reader :client

  def initialize(spotify_client)
    @client=spotify_client
  end

  def load_artist_from_id(artist_id)

    artist_response = @client.get_artist(artist_id)
    
    artist = Artist.new(
      artist_response['name'],
      artist_response['popularity']
    )
    
    ## TODO: Remove hard coded market
    tracks_response = @client.get_artist_top_tracks(
      artist_id,
      'CL'
    )

    tracks_response['tracks'].each { |track_response|
      
      new_track = Track.new(
        track_response['name'],
        track_response['popularity']
      )
      new_track.set_preview_url = track_response['preview_url']

      artist.add_track(new_track)
    }
    return artist
  end
end