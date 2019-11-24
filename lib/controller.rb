class MusicLibraryController

    def initialize(path = './db/mp3s')
        MusicImporter.new(path).import
    end

    def call
        greeting
        status = 'looping'
        until status == 'exit' do
            case gets.chomp
                
            when 'list songs'
                list_songs
            when 'list artists'
                list_artists
            when 'list genres'
                list_genres
            when 'list artist'
                list_songs_by_artist
            when 'list genre'
                list_songs_by_genre
            when 'play song'
                play_song
            when 'exit'
                status = 'exit'
            end
        end
    end
    
    def greeting
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
    end

    def list_songs
        alpha_songs = Song.all.sort{|a, b| a.name <=> b.name}
        alpha_songs.each.with_index(1) do |song, index|
            artist, name, genre = song.artist.name, song.name, song.genre.name
             puts "#{index}. #{artist} - #{name} - #{genre}"
        end
    end

    def list_artists
        alpha_artists = Artist.all.sort{|a, b| a.name <=> b.name}
        alpha_artists.each.with_index(1) do |artist, index|
            puts "#{index}. #{artist.name}"
        end
    end

    def list_genres
        alpha_genres = Genre.all.sort{|a, b| a.name <=> b.name}
        alpha_genres.each.with_index(1) do |genre, index|
            puts "#{index}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        
        if Artist.all.any?{|artist| artist.name == input }
            artist = Artist.find_by_name(input) 
            alpha_songs = artist.songs.sort{|a, b| a.name <=> b.name}
        
            alpha_songs.each.with_index(1) do |song, index|
                song, genre = song.name, song.genre.name
                puts "#{index}. #{song} - #{genre}"
            end
        end 
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp

        if Genre.all.any?{|genre| genre.name == input }
            genre = Genre.find_by_name(input) 
            alpha_songs = genre.songs.sort{|a, b| a.name <=> b.name}
            
            alpha_songs.each.with_index(1) do |song, index|
                artist, song = song.artist.name, song.name
                puts "#{index}. #{artist} - #{song}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp.to_i

        if input.between?(1,Song.all.size)
            alpha_songs = Song.all.sort{|a, b| a.name <=> b.name}
            selected_song = alpha_songs[input - 1]
            artist, song = selected_song.artist.name, selected_song.name

            puts "Playing #{song} by #{artist}"
        end
    end
end