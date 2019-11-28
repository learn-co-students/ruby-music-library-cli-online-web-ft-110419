class Song < Music
  extend Concerns::Findable
  attr_accessor :artist, :genre, :name
  @@all = []
  
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
    artist_name,song_name,genre_name = file_name.split(/\s-/).map{|f|f.strip}
    artist_name = artist_name.split("/").last
    
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name[0...-4])
    song = Song.new(song_name,artist,genre)
  end

  def self.create_from_filename(file_name)
    song = self.new_from_filename(file_name)
    @@all << song
  end
  
  def save
    @@all << self
  end
  
  def self.all 
    @@all
  end
  
end