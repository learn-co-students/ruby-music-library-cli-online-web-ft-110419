require "pry"
class Song
  attr_accessor :name
  attr_reader :artist, :genre
    @@all = []
  def initialize(name,artist = nil,genre = nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre

    @@all << self
  end
  def genre=(genre)
    @genre = genre
    genre.songs << self if !genre.songs.find {|song| song == self}

  end
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  def self.all
    @@all
  end
  def self.destroy_all
    @@all.clear
  end
  def save
    @@all << self
  end
  def self.create(name)
    self.new(name)
    self
  end
  def self.find_by_name(name)
    Song
  end
  def self.find_or_create_by_name(name)
   self.find_by_name(name) || self.create(name)

  end
end
