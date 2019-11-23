class Song
  attr_accessor :genre, :artist, :name
  @@all = []
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
  
  def save
    @@all << self 
  end
  
  def self.all 
    @@all 
  end
  
  def self.create(name)
    new = self.new(name) 
    new.save 
    new
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def self.new_from_filename(filename)
    #remove ".mp3" from end of filename
    filename = filename[0..-5]
    #split filename into artist, name and genre
    filename = filename.split(" - ")
    artist = Artist.find_or_create_by_name(filename[0])
    genre = Genre.find_or_create_by_name(filename[2])
    song = Song.new(filename[1], artist, genre)
  end
  
  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end
  
end