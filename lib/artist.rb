class Artist
  extend Concerns::Findable
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    save
  end

  def self.all
    @@all.uniq
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    self.new(name)
  end

  def songs
    @songs
  end

  def add_song(song)
    if !song.artist
      song.artist = self
        if !songs.include?(song)
          @songs << song
      end
    end
  end

  def genres
      songs.map(&:genre).uniq
    end

end #end of class
