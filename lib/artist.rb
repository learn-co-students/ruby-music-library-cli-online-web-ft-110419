class Artist
    
    @@all = []

    attr_accessor :name, :songs

    def initialize(name)
        @name = name
        #super
        @songs = []
    end

    def songs
        @songs
    end

    def add_song(song)
        song.artist ||= self
        songs << song unless songs.include?(song)
    end

    def genres
        songs.each.collect{|song| song.genre }.uniq
    end
    #TODO All of this should be modularized
    def self.all
        @@all
    end

    def self.destroy_all
        all.clear
    end

    def self.create(name)
        artist = Artist.new(name)
        artist.save #! This .save may cause issues
        artist
    end
    def save
        self.class.all << self
    end
end