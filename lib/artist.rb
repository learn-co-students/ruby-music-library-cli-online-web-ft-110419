class Artist < Music
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
  
  def add_song(song)
    songs << song if !songs.include? song
    song.artist = self if song.artist != self
  end
  
  def genres 
    songs.map {|song| song.genre }.uniq
  end
  
end