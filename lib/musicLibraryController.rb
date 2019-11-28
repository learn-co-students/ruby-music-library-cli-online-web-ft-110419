 class MusicLibraryController
  attr_accessor :music_importer,:songs_files
  def initialize(path='./db/mp3s')
    @music_importer = MusicImporter.new(path)
    @songs_files = music_importer.import
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
    input = gets.chomp
    call if input != "exit"
  end
  
  def list_songs
    sorted_files = songs_files.sort{|a,b| a.split("-")[1].strip <=> b.split("-")[1].strip}
    sorted_files.each.with_index(1) {|f,i| puts "#{i}. #{f.match(/[A-Z].*(?=\.mp3)/)}"}
  end
  
  def list_artists
    artists = Artist.all.map{|artist| artist.name}
    artists.sort {|a,b| a <=> b }.each.with_index(1) {|artist,i| puts "#{i}. #{artist}"  }
  end
  
  def list_genres
    genres = Genre.all.map{|genre| genre.name}
    genres.sort {|a,b| a <=> b }.each.with_index(1) {|genre,i| puts "#{i}. #{genre}"  }
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    artist_songs = Song.all.select{|song|song.artist.name == input}
    artist_songs.sort {|a,b| a.name <=> b.name }.each.with_index(1){|song,i| puts "#{i}. #{song.name} - #{song.genre.name}"}
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    genre_songs = Song.all.select{|song|song.genre.name == input}
    genre_songs.sort {|a,b| a.name <=> b.name }.each.with_index(1){|song,i| puts "#{i}. #{song.artist.name} - #{song.name}"}
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp
    if !input.zero?
      index = input - 1
      binding.pry
    end
    # puts "Playing Larry Csonka by Action Bronson"
    
  end
    
end
  
  
  