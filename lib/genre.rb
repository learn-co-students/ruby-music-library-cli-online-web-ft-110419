class Genre 
  extend Concerns::Findable
  
  attr_accessor :name
  attr_accessor :songs
  
  @@all = [] 
  
  def initialize(name)
    @name = name
    @songs = []
  end 
  
  def self.all 
    @@all
  end 
  
  def save
    @@all << self
  end 
  
  # def self.reset_all 
  #   @@all.clear 
  # end 
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(name)
    genre = new(name)
    genre.save
    genre 
  end
  
  def artists
    songs.collect{ |s| s.artist }.uniq 
  end 
  # def self.find_by_name(name)
  #   @@all.detect{|genre| genre.name == name}
  # end
end 