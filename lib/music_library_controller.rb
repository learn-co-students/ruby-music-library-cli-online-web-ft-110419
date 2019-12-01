class MusicLibraryController

    def initialize(path = './db/mp3s')
        new_controller = MusicImporter.new(path)
        new_controller.import

    end



    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        requests = ['exit', 'play song', 'list genre', 'list genres',
            'list artist', 'list artists', 'list songs']
        input = gets.strip until requests.include?(input)
        if input == 'list songs'
            list_songs
        elsif input == 'list artists'
            list_artists
        elsif input == 'list genres'
            list_genres
        elsif input == 'list artist'
            list_songs_by_artist
        elsif input == 'list genre'
            list_songs_by_genre
        elsif input == 'play song'
            play_song
        end


        
        
    end

    def list_songs
        song_list = Song.all.sort! {|a,b| a.name <=> b.name}
        song_list.each_with_index do |song, index|
            puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        artist_list = Artist.all.sort! {|a,b| a.name <=> b.name}
        artist_list.collect! {|artist| artist.name}.uniq.each_with_index {
            |artist, index| puts "#{index+1}. #{artist}"}

    end

    def list_genres
        genre_list = Genre.all.sort! {|a,b| a.name <=> b.name}
        genre_list.collect! {|genre| genre.name}.uniq.each_with_index {
            |genre, index| puts "#{index+1}. #{genre}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        song_list = Song.all.sort! {|a,b| a.name <=> b.name}
        song_num = 1
        song_list.each do |song|
            if song.artist.name == input
                puts "#{song_num}. #{song.name} - #{song.genre.name}"
                song_num += 1
            end    
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        song_list = Song.all.sort! {|a,b| a.name <=> b.name}
        song_num = 1
        song_list.each do |song|
            if song.genre.name == input
                puts "#{song_num}. #{song.artist.name} - #{song.name}"
                song_num += 1
            end    
        end
    end

    def play_song
        song_list = Song.all.sort! {|a,b| a.name <=> b.name}
        puts "Which song number would you like to play?"
        input = gets.strip
        if input.to_i.between?(1, song_list.length)
            if input.to_i != 0
                pick_song = song_list[input.to_i-1]
                puts "Playing #{pick_song.name} by #{pick_song.artist.name}"
            end
        end
    end


end
