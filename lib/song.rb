require_relative "./music.rb"
class Song < Music
  attr_reader :artist
  # attr_accessor :artist
  
 def initialize(name,artist_obj=nil)
    super
    @artist = artist_obj
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self) if !artist.songs.include? self
  end

end