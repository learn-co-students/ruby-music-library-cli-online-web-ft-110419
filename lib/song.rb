class Song

    attr_accessor :name, :artist , :genre 
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
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
        song = Song.new(name)
        @@all << song 
        song
    end 

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end 

    def genre=(genre)
        @genre = genre
        if !(@genre.songs.include?(self))
            genre.songs << self 
        end 
    end 

    def self.find_by_name(name)
       all.detect {|song| song.name == name}
    end 

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end 

    def self.new_from_filename(name)
        info = name.split(" - ")
        song_name = info[1]
        artist_name = info[0]
        genre_name = info[2].chomp(".mp3")
        song = self.new(song_name)
        song.artist =  Artist.find_or_create_by_name(artist_name)
        song.genre = Genre.find_or_create_by_name(genre_name)
        song
    end 

    def self.create_from_filename(name)
        new_from_filename(name).tap {|x| x.save}
    end 


end 