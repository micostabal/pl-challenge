require_relative "domain"
require "test/unit"

class RelevantTests < Test::Unit::TestCase
  @@artists = [
    Artist.new('Coldplay', 78),
    Artist.new('Radiohead', 78),
    Artist.new('ABBA', 78),
    Artist.new('David Bowie', 80)
  ]
  
  @@tracks = [
    Track.new('Yellow', 80),
    Track.new('Let\'s dance', 80),
    Track.new('High', 80),
    Track.new('Dancing Queen', 82),
    Track.new('Viva la vida', 80),
    Track.new('The Scientist', 79),
    Track.new('No Surprises', 81)
  ]
  
  def test_track_order
    yellow = @@tracks[0]
    lets_dance = @@tracks[1]
    assert_equal(yellow < lets_dance, true)
  end
  
  def test_artist_order
    coldplay = @@artists[0]
    radiohead = @@artists[1]
    assert_equal(coldplay < radiohead, true)
  end
  
  def test_artist_gets_first_track_right_multiple_max
    coldplay = @@artists[0]
    
    coldplay.add_track(@@tracks[0])
    coldplay.add_track(@@tracks[4])
    coldplay.add_track(@@tracks[5])
    
    first_track = coldplay.get_most_popular_track
    
    assert_equal(first_track.name, @@tracks[4].name)
  end

  def test_artist_gets_first_track_right_single_max
    radiohead = @@artists[1]
    
    radiohead.add_track(@@tracks[2])
    radiohead.add_track(@@tracks[6])
    
    first_track = radiohead.get_most_popular_track
    
    assert_equal(first_track.name, @@tracks[6].name)
  end
 
end