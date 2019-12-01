class Song
    attr_accessor :name 
    attr_reader :artist, :genre

    @@all =[]

    def initialize(name, artist_obj = nil, genre_obj = nil)
        @name = name
        self.artist = artist_obj unless artist_obj == nil
        self.genre = genre_obj unless genre_obj == nil
        self.save
    end

    def save
        @@all << self
    end
    
    def self.find_by_name(song_name)
        Song.all.select {|x| x.name == song_name}[0]
    end

    def self.find_or_create_by_name(song_name)
        if Song.find_by_name(song_name) == nil
            Song.create(song_name)
        else
            Song.find_by_name(song_name)
        end
    end

    def genre=(genre_obj)
        @genre = genre_obj
        genre_obj.add_song(self)
    end

    def artist=(artist_obj)
        @artist = artist_obj
        artist_obj.add_song(self)
    end

    def self.all
        @@all.uniq
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(song_name)
        Song.new(song_name).tap do |new_song|    
            new_song.save
        end
    end

    def self.new_from_filename(filename)
        parsed_song = filename.split(" - ")
        new_song = Song.find_or_create_by_name(parsed_song[1])
        artist_obj = Artist.find_or_create_by_name(parsed_song[0])
        new_song.artist = artist_obj
        genre_obj = Genre.find_or_create_by_name(parsed_song[2].chomp(".mp3"))
        new_song.genre = genre_obj
        # parsed_song[2].delete(".mp3")
        new_song
    end

    def self.create_from_filename(filename)
        new_song = Song.new_from_filename(filename)
        new_song.save
    end



end
