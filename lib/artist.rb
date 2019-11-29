class Artist
  
  extend Concerns::Findable

  @@all = []

  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    self.name = name
    @songs = []
  end


  def self.all
    @@all
  end


  def self.destroy_all
    @@all.clear
  end


  def self.create(name)
    artist = new(name)
    artist.save
    artist
  end


  def save
    @@all << self
  end


  def add_song(song)
    song.artist = self if !song.artist
    @songs << song if !@songs.include? song
  end


  def genres
    @songs.collect {|song| song.genre}.uniq
  end


end

