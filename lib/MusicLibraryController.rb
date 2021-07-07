require 'pry'
class MusicLibraryController
  attr_accessor :path 
  
  extend Concerns::Findable
  def initialize(path="./db/mp3s")
    @path = path 
    new_MusicImporter = MusicImporter.new(path)
    new_MusicImporter.import
  end 
  
  def call 
    user_input = ""
     while user_input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      
       user_input = gets.strip
    case user_input
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
     end 
    end
     
  end 
  
  def list_songs
    # sorts all songs in abc order and numbers them
    Song.all.sort {|a, b|  a.name <=> b.name }
    .each.with_index(1) do |s, i|
        puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
      end
  end 
  
  def list_artists
     Artist.all.sort_by {|artist| artist.name }.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist.name}"
    end
  end
  
  def list_genres 
    Genre.all.sort_by {|genre| genre.name}
     .each.with_index(1) {|gen, index| puts "#{index}. #{gen.name}"}
  end 
  
  def list_songs_by_artist 
    puts "Please enter the name of an artist:"
    user_input = gets.chomp 
    if Artist.find_by_name(user_input)
      Artist.find_by_name(user_input).songs.sort_by {|song| song.name}.each.with_index(1) {|song, index| puts "#{index}. #{song.name} - #{song.genre.name}"}
    end
  end 
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.chomp 
    if Genre.find_by_name(user_input)
      Genre.find_by_name(user_input).songs.sort_by {|genre| genre.name}.each.with_index(1) { |g, index| puts "#{index}. #{g.artist.name} - #{g.name}"}
    end
  end
  
  def play_song 
     puts "Which song number would you like to play?"
     sorting =  Song.all.sort_by {|song| song.name}
      order_song = sorting.collect { |s| s.name }
      artist = sorting.collect { |s| s.artist.name }
        user_input = (gets.chomp.to_i) -1
     puts "Playing #{order_song[user_input]} by #{artist[user_input]}" if user_input < order_song.length and user_input > 0
  end 
end 