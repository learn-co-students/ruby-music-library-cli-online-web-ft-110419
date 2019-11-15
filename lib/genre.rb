class Genre
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
  
  def artists
    temp = []
    @songs.each { |song|
      temp << song.artist if !temp.include?(song.artist)
    }
    return temp
  end
  
  def self.all
    return @@all
  end
  
  def self.create(name)
    genre = self.new(name)
    genre.save
    return genre
  end
  
  def self.destroy_all
    @@all.clear
  end
end
