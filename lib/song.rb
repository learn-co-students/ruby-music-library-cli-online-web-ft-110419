class Song < Music
  extend Concerns::Findable
  attr_accessor :artist, :genre, :name
  
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
  
  def self.new_from_filename(file_name)
    artist_name,song_name,genre_name = file_name.split("-").map{|f|f.strip}
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name[0...-4])
    song = Song.new(song_name,artist,genre)
  end

end