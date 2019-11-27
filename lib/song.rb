class Song
  attr_accessor :name, :artist
    @@all = []
  def initialize(name,artist)
    @name = name
    @artist = artist if artist
    @@all << self
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
    save
    self
  end
end
