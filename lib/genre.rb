class Genre
  extend Concerns::Findable
  attr_accessor :name
  @@all = []

  def initialize(name)
      @name = name
      @songs = []
      save
    end

    def self.all
      @@all
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

    def artists
      songs.map(&:artist).uniq
     end


end #end of class
