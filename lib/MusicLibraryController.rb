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
    input = gets.chomp
    while input != "exit" && input != "Exit"
      puts "Welcome to your music library!"
      puts "What would you like to do?"
      input = gets.chomp
    end
  end
  
  def list_songs
    split_array = @files.map{|file| file.split(" - ")}
    sorted = split_array.sort_by{|file| file[1]}
    rejoined = sorted.join(" - ").split(".mp3 ")
    rejoined.each_with_index do |file, index|
      if file[0..1] == "- "
        file = file[2..-1]
      end
      puts "#{index+1}. #{file}"
    end
  end
end


  
    #   case input 
    #     when "list artists" || "List artists"
    #       Artist.all 
    #     when "list genres" || "List genres"
    #       Genre.all
    #     when "list songs" || "List songs"
    #       Song.all 
    #     when "list genre" || "List genre"
    #       genre.songs

