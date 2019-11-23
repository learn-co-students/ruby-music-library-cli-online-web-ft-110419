class MusicLibraryController
  attr_accessor :files
  def initialize(path = './db/mp3s')
    music_importer = MusicImporter.new(path)
    @files = music_importer.import
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
    puts "Welcome to your music library!"
    input = gets.chomp
    case input 
      when "list artists" || "List artists"
        self.list_artists
      when "list genres" || "List genres"
        self.list_genres
      when "list songs" || "List songs"
        self.list_songs
      when "list genre" || "List genre"
        self.list_songs_by_genre
      when "list artist" || "List artist"
        self.list_songs_by_artist
      when "play song"
        self.play_song
    end
    while input != "exit" && input != "Exit"
      puts "Welcome to your music library!"
      input = gets.chomp
    end
  end
  
  def list_songs
    names = Song.all.sort_by{|song| song.name}
    names.each_with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end 
  end
  
  def list_genres
    sorted = Genre.all.sort_by{|genre| genre.name}
    sorted.each_with_index do |genre, index|
      puts "#{index+1}. #{genre.name}"
    end 
  end
  
  def list_artists
    names = Artist.all.map{|artist| artist.name}
    names = names.sort
    names.each_with_index do |artist, index|
      puts "#{index+1}. #{artist}"
    end 
  end 
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    artist = Artist.all.find{|artist| artist.name == input} 
    if artist
      songs_sorted = artist.songs.sort_by{|song| song.name} 
      songs_sorted.each_with_index do |song, index| 
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end 
    end 
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    genre = Genre.all.find{|genre| genre.name == input}
    if genre
      songs_sorted = genre.songs.sort_by{|song| song.name}
      songs_sorted.each_with_index do |song, index|
        puts "#{index + 1}. #{song.artist.name} - #{song.name}"
      end 
    end 
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i
    names = Song.all.sort_by{|song| song.name}
    if input > 0 && input < names.length
      puts "Playing #{names[input - 1].name} by #{names[input-1].artist.name}"
    end
  end
end

