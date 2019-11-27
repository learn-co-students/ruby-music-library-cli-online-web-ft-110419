class Artist
  attr_accessor :name ,:songs

      @@all = []
  def initialize(name)
    @name = name
    @songs = []
    @@all << self
  end
  def add_song(song)
    if song.artist
       nil
     else
        song.artist = self
        self.songs << song
      end

  end
  def self.all
    @@all
  end
  def self.destroy_all
    @@all.clear
  end
  def songs
    @songs
  end
  def save
    @@all << self
  end
  def self.create(name)
    self.new(name)

  end
end
