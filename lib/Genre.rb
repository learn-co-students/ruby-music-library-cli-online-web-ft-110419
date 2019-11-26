require 'pry'
class Genre 
  attr_accessor :name, :songs 
  @@all = []
  
  def initialize(name)
    @name = name 
    @songs = []
    @@all << self 
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
  
  def self.create(genre)
    genres = self.new(genre)
    @@all << genre
    genres
  end 
  
  def artists
    Artist.all
  end 
  
  
end 