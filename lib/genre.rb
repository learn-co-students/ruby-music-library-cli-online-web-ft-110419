class Genre

    @@all = []

    attr_accessor :name, :songs

    def initialize(name)
        @name = name
        @songs = []
    end

    def artists
        songs.collect{|song| song.artist}.uniq
    end
    #TODO All of this should be modularized
    def self.all
        @@all
    end

    def self.destroy_all
        all.clear
    end

    def self.create(name)
        genre = Genre.new(name)
        genre.save
        genre
    end
    def save
        self.class.all << self
    end

end