require 'pry'
class Song 
  extend Concerns::Findable
  attr_accessor :name 
  attr_reader :artist, :genre 
  @@all = []
  def initialize(name, artist=nil, genre=nil)
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
  
  def self.create(name) 
    song = self.new(name)
    song.save
    song
  end 
  
  def artist=(artist)
      @artist = artist
     artist.add_song(self)
  end
  
  def genre=(genre)
     @genre = genre
     if genre.songs.include?(self)
       genre.songs 
      else 
        genre.songs << self
      end 
  end 
  
  def self.new_from_filename(filename)
    artist, song, genre = filename.split(" - ")
   find_art =  Artist.find_or_create_by_name(artist)
   find_gen =  Genre.find_or_create_by_name(genre.gsub(".mp3", ""))
    self.new(song, find_art, find_gen)
  end 
  
  def self.create_from_filename(filename) 
    @@all << self.new_from_filename(filename)
  end 
end 