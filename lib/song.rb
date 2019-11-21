require_relative "./music.rb"
require 'pry'
class Song < Music
  attr_accessor :artist, :genre
  
 def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self if !genre.songs.include? self
  end
  
  def self.find_by_name(song_name)
    self.all.find {|song| song.name == song_name }
  end
  
  def self.find_or_create_by_name(song_name)
    if self.find_by_name(song_name)
      self.find_by_name(song_name)
    else 
      song = self.new(song_name)
      self.all << song
    end
  end

end