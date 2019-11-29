class Genre
  
  extend Concerns::Findable

  @@all = []

  attr_accessor :name
  attr_reader :songs, :song

  
  def initialize(name, song=nil)
    @name = name
    self.song = song if song 
    @songs = []
  end


  def self.all
    @@all
  end


  def self.destroy_all
    @@all.clear
  end


  def self.create(name)
    genre = new(name)
    genre.save
    genre
  end


  def save
    @@all << self
  end

  def add_song(song)
    song.genre = self if !song.genre 
    @songs << song if !@songs.include? song
  end


  def artists
    @songs.collect {|song| song.artist}.uniq
  end



end
