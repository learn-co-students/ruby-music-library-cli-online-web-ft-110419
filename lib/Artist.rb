class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    # binding.pry
    song.artist = self if !song.artist
    self.songs << song if !self.songs.include?(song)
  end

  def genres
    self.songs.collect do |song|
      song.genre
    end.uniq
  end

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def self.destroy_all
    self.all.clear
  end
end