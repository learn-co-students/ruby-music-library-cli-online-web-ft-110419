class Genre < Music
  extend Concerns::Findable
  attr_accessor :songs
  @@all = []
  
  def initialize(name)
    super
    @songs = []
  end
  
   def save
    @@all << self
  end
  
  def self.all 
    @@all
  end
  
  def artists
    songs.map {|song| song.artist }.uniq
  end
end