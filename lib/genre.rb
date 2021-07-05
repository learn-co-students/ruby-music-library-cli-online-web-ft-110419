require 'findable.rb'
class Genre
  extend Concerns::Findable
  attr_accessor :name
  @@all = []

  def initialize(name)
    self.name = name
    self.save
    @songs = []
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
    genre = self.new(name)
    genre.name = name
    return genre
  end

  def songs
    @songs
  end

  def artists
    songs.collect{|song| song.artist}.uniq
  end
end
