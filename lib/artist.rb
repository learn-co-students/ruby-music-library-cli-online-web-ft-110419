class Artist
  extend Concerns::Findable
  
  attr_accessor :name
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save
    @@all << self if !@@all.include?(self)
  end
  
  def songs
    return @songs
  end
  
  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song if !@songs.include?(song)
  end
  
  def genres
    temp = []
    @songs.each { |song|
      temp << song.genre if !temp.include?(song.genre)
    }
    return temp
  end
  
  def self.all
    return @@all
  end
  
  def self.create(name)
    artist = self.new(name)
    artist.save
    return artist
  end
  
  def self.destroy_all
    @@all.clear
  end
end
