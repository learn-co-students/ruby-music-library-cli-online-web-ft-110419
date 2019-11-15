class Song
  extend Concerns::Findable
  
  attr_accessor :name
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def save
    @@all << self if !@@all.include?(self)
  end
  
  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end
  
  def artist
    return @artist
  end
  
  def genre=(genre)
    @genre = genre
    @genre.songs << self if !@genre.songs.include?(self)
  end
  
  def genre
    return @genre
  end
  
  def self.new_from_filename(filename)
    song = self.find_or_create_by_name(filename.split(" - ")[1])
    song.artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
    song.genre = Genre.find_or_create_by_name(filename.split(" - ")[2].split(".mp3")[0])
    return song
  end
  
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    return song
  end
  
  def self.all
    return @@all
  end
  
  def self.create(name)
    song = self.new(name)
    song.save
    return song
  end
  
  def self.destroy_all
    @@all.clear
  end
end
