
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
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    song = self.new(name)
    song.save
    song
  end
  
  def self.new_from_filename(file_name)
    file_string = file_name.split(" - ")
    artist = Artist.find_or_create_by_name(file_string[0])
    genre = Genre.find_or_create_by_name(file_string[2].gsub(/.mp3/,""))
    self.new(file_string[1], artist, genre)
  end
  
  def self.create_from_filename(file_name)
    self.all << self.new_from_filename(file_name)
  end
  
  def self.all 
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
end