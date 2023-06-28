require 'uri'
require 'json'
require 'net/http'


class SpotifyClient
  ## TODO: Move to config file
  @@TOKEN_URL = 'https://accounts.spotify.com/api/token'
  @@ARTISTS_URL = 'https://api.spotify.com/v1/artists'

  attr_reader :token
  
  def initialize(client_id, client_secret)
    @client_id = client_id
    @client_secret = client_secret
    @token = nil
  end
  
  def set_token=(new_token)
    @token=new_token
  end
  
  def authenticate()
    params = {
      :grant_type => "client_credentials",
      :client_id => @client_id,
      :client_secret => @client_secret
    }

    url = URI.parse(@@TOKEN_URL)
    
    request = Net::HTTP::Post.new(url.path)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request.set_form_data( params )
    
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    
    response = execute_https_request(request, url)
    
    self.set_token = response['access_token']
  end
  
  def get_artist(artist_id)
    url = URI("#{@@ARTISTS_URL}/#{artist_id}")
    
    request = self.create_authorized_get_request(url)
    
    return self.execute_https_request(request, url)
  end
  
  def get_artist_top_tracks(artist_id, market)
    url = URI.parse("#{@@ARTISTS_URL}/#{artist_id}/top-tracks?market=#{market}")
    
    request = self.create_authorized_get_request(url)
    
    return self.execute_https_request(request, url)
  end

  def execute_https_request(request, url)
    ## TODO: See if we can wrap all requests inside ths context
    ## to speed up the requests
    response = Net::HTTP.start(url.hostname, url.port,
      :use_ssl => url.scheme == 'https') { |http|
      http.request(request)
    }
    
    return JSON.parse(response.body)
  end
  
  def create_authorized_get_request(url)
    request = Net::HTTP::Get.new(url)
    
    request['Authorization'] = "Bearer #{@token}"
    
    return request
  end

end