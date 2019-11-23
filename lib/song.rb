class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre=nil)
    @name = name
    self.artist=(artist)
    self.genre=(genre)
  end

  def artist=(artist)
    # binding.pry
    @artist = artist
    artist.add_song(self) if artist
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if genre && !genre.songs.include?(self)
  end

  def self.find_by_name(name)
    self.all.find { |s| s.name == name }
  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    song ? song : self.create(name)
  end

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end

  def self.destroy_all
    self.all.clear
  end
end