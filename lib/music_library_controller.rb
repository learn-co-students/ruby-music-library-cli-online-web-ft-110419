require 'pry'
class MusicLibraryController
  
  attr_accessor
  
  def initialize(path="./db/mp3s")
    MusicImporter.new(path).import
  end
  
  def call
    self.greeting
    input = gets.strip
    case input
      when 'list songs'
        self.list_songs
      when 'list artists'
        self.list_artists
      when 'list genres'
        self.list_genres
      when 'list artist'
        self.list_songs_by_artist
      when 'list genre'
        self.list_songs_by_genre
      when 'play song'
        self.play_song
      when 'exit'
      else
        puts "Invalid input - try again"
        call
    end
  end
  
  def list_songs
    sorted_songs = Song.all.sort_by{|song| song.name}
    sorted_songs.each.with_index(1) do |song, index| 
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    sorted_artists = Artist.all.sort_by{|artist| artist.name}
    sorted_artists.each.with_index(1){|artist, index| puts "#{index}. #{artist.name}"}
  end
  
  def list_genres
    sorted_genres = Genre.all.sort_by{|genre| genre.name}
    sorted_genres.each.with_index(1){|genre, index| puts "#{index}. #{genre.name}"}
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    exists = Artist.find_by_name(input)
    if exists
      exists.songs.sort_by{|song| song.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    exists = Genre.find_by_name(input)
    if exists
      exists.songs.sort_by{|song| song.name}.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  def play_song
    sorted_songs = Song.all.sort_by{|song| song.name}
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    index = input - 1
    if  index >= 0 && index < sorted_songs.length
      puts "Playing #{sorted_songs[index].name} by #{sorted_songs[index].artist.name}"
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
  
end