require_relative '../lib/concerns/findable.rb'

class Artist
    attr_accessor :name
    attr_reader :songs
    
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
        song.artist = self unless song.artist.is_a? Artist
        @songs << song unless @songs.include?(song)

    end

    def genres
        Song.all.collect do |x|
            if x.artist == self
                x.genre
            end
        end.uniq
    end


    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(artist_name)
        Artist.new(artist_name).tap do |new_artist|    
            new_artist.save
        end
    end

end
