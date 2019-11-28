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
    songs_list = sorted_files.map.with_index(1) {|f,i| "#{i}. #{f.match(/[A-Z].*(?=\.mp3)/)}"}
    
    for song in songs_list
      puts song
    end
  end
  
  def list_artists
    artists = Artist.all.map{|artist| artist.name}
    sorted_artist = artists.sort {|a,b| a <=> b }.each.with_index(1) {|artist,i| puts "#{i}. #{artist}"  }
    # artist_list = sorted_artist.map.with_index() {|artist,i| "#{i+1}. #{artist}" }

    # for artist in artist_list
    #   puts artist
    # end
  end
  
end