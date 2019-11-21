require_relative "./music.rb"
require 'pry'
class Artist < Music
  attr_accessor :songs
  
  def initialize(name)
    super
    @songs = []
  end
  
  def songs
    @songs
    # Song.all.select {|song| song.artist == self }
  end
  
  def add_song(song)
    songs << song if !songs.include? song
    song.artist = self if song.artist != self
  end
  
end