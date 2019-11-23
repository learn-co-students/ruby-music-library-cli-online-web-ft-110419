class Song
  extend Concerns::Findable
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

  def self.new_from_filename(filename)
    artist_name, song_name, genre_name = filename.gsub(".mp3", "").split(" - ")
    # binding.pry
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = self.find_or_create_by_name(song_name)
    song.artist = artist
    song.genre = genre
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
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