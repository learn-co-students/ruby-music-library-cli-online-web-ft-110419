require 'pry'
class Artist 
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs
  @@all =[]
  def initialize(name)
    @name = name 
    @songs = []
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.destroy_all 
    @@all.clear 
  end 
  
  def save
    @@all << self 
  end 
  
  def self.create(artist)
    artists = self.new(artist)
    artists.save
    artists 
  end 

  def add_song(song) 
    
      if !songs.include?(song)
          @songs << song
      end
      
      if song.artist 
        song.artist 
      else 
        song.artist = self
      end 
      
  end 
  
  def genres
    songs.collect {|song| song.genre}.uniq
  end 
end 