require 'pry'

class Song 
  attr_accessor :name, :artist, :genre 
  @@all = []
  
  def initialize(name, artist = nil, genre = nil )
    @name = name 
    self.artist = artist if artist 
    self.genre = genre if genre 
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
    
  def self.create(song)
    new_song = self.new(song)
    new_song.save
    new_song 
  end 
  
  def artist=(artist)
    @artist = artist 
    artist.add_song(self)
  end 
  
  def genre=(genre)
    @genre = genre 
    genre.songs << self unless genre.songs.include?(self)
  end 
  
  def self.find_by_name(name)
    self.all.find {|song| return song if song.name == name}
  end 
  
  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end 
  
  # def new_from_filename(filename)
  #   artist = file_name.split(" - ")[0]
  #   song = file_name.split(" - ")[1]
  #   song = self.create(song)
  #   song.artist_name = artist 
  #   @song = song  
  # end 
  
  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    artist_name = parts[0]
    song_name = parts[1]
    genre_name = parts[2].gsub(".mp3", "")
    
    artist_name = Artist.find_or_create_by_name(artist_name)
    genre_name = Genre.find_or_create_by_name(genre_name)
    
    new(song_name, artist_name, genre_name)
    
  end 
  
  def self.create_from_filename(filename)
    @@all << self.new_from_filename(filename)
  end 
      
  # def self.find_or_create_by_name(name)
  #   self.all.detect {|artist| artist.name == name} || Artist.new(name)
  # end 
  
end 