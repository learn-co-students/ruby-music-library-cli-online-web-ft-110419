require_relative "./music.rb"
class Genre < Music
  attr_accessor :songs
  
  def initialize(name)
    super
    @songs = []
  end
  
  def artists
    songs.map {|song| song.artist }.uniq
  end
end