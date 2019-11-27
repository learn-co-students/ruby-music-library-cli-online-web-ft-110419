require "pry"
class Genre
  @@all = []
  attr_accessor :name, :songs
  def initialize(name)
    @name = name
    @songs = []
    @@all << self
  end
  def self.all
    @@all
  end
  def genre_songs
    Song.all.find_all {|song| song.genre == self}
  end
  def artists
  genre_artist = genre_songs.map do |song|
        song.artist
    end.uniq
  end
  def self.destroy_all
    @@all.clear
  end
  def save
    @@all << self
  end
  def self.create(name)
    self.new(name)
  end
end
