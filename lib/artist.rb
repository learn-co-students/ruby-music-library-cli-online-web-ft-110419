
class Artist
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :songs  
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def add_song(song)
    song.artist ||= self
    self.songs << song unless self.songs.include?(song)
  end
  
  def genres 
    songs.map{|song| song.genre}.uniq
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end
  
  def self.all 
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
end