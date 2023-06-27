

class Artist
  attr_reader :name, :popularity, :tracks
  
  def initialize(name, popularity)
    @name=name
    @popularity=popularity
    @tracks = []
  end
  
  include Comparable
  attr :str
  def <=>(other)
    return @name <=> other.name
  end

  def add_track(new_track)
    @tracks.push(new_track)
  end
  
  def to_s()
    "#{@name}, whose popularity is #{@popularity}."
  end
  
  def get_most_popular_track()
    if @tracks.length() == 0
      return nil
    end
    @tracks.sort.reverse.first()
  end
  
  def summary()
    base = 'Artist '+to_s()
    track = ''
    if @tracks.length()>0
      track = ", whose star track is #{get_most_popular_track().to_s()}"
    end
    return base+track
  end

end


class Track
  attr_reader :name, :popularity

  def initialize(name, popularity)
    @name=name
    @popularity=popularity
    @preview_url = nil 
  end

  def set_preview_url=(new_url)
    @preview_url = new_url
  end
  
  include Comparable
  attr :str
  def <=>(other)
    if @popularity != other.popularity
      return @popularity <=> other.popularity
    end
    return @name > other.name ? -1 : 1
  end
  
  def to_s()
    base = "#{@name} ( popularity #{@popularity}"
    url = @preview_url != nil ? ", preview here #{@preview_url})." : ').'
    return base+url
  end

end