require_relative '../lib/concerns/findable.rb'

class Genre
    attr_accessor :name
    attr_reader :songs, :artists

    extend Concerns::Findable

    @@all =[]

    def initialize(name)
        @name = name
        @songs = []
        self.save
    end

    def save
        @@all << self
    end

    def add_song(song)
        song.genre = self unless song.genre.is_a? Genre
        @songs << song unless @songs.include?(song)

    end

    def artists
        Song.all.collect do |x|
            if x.genre == self
                x.artist
            end
        end.uniq
    end


    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(genre_name)
        Genre.new(genre_name).tap do |new_genre|    
            new_genre.save
        end
    end

end
