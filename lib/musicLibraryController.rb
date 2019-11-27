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
    songs_list = sorted_files.map.with_index {|f,i| "#{i+1}. #{f.match(/[A-Z].*(?=\.mp3)/)}"}
    
    for song in songs_list
      puts song
    end
  end
  
  def list_artists
    artists = songs_files.map {|file| file.split("-")[0].strip}
    binding.pry
    for artist in artists
      puts artist
    end
  end
  
end