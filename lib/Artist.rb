class Artist
  extend Concerns::Findable 
  attr_accessor :songs, :name
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def save
    @@all << self 
  end
  
  def self.all 
    @@all 
  end
  
  def self.create(name)
    new = self.new(name) 
    new.save 
    new
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def add_song(song)
    if !song.artist
      song.artist = self
    end
    if !@songs.include?(song)
      @songs << song
    end
  end
  
  def genres 
    @songs.map{|song| song.genre}.uniq
  end
end