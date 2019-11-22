class Song < Music
  attr_accessor :genre, :artist
  extend Concerns::Findable
  
  def initialize(name, artist = nil, genre = nil) 
    @name = name 
    self.genre = genre if genre
    self.artist = artist if artist
  end 
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    if !@genre.songs.include?(self)
      @genre.songs << self
    end
  end
  
end