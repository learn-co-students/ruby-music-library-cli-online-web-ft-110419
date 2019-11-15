class MusicLibraryController
  attr_accessor :current_list
  
  def initialize(path = "./db/mp3s")
    @music_importer = MusicImporter.new(path)
    @music_importer.import
    @current_list = sort_data(Song.all)
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
    input = ""
    until input == "exit" do
      puts "What would you like to do?"
      input = gets.strip
      case input
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
      end
    end
  end
  
  def list_songs
    number = 1
    @current_list = sort_data(Song.all)
    @current_list.each { |song|
      puts "#{number}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      number += 1
    }
  end
  
  def list_artists
    number = 1
    @current_list = sort_data(Artist.all)
    @current_list.each { |artist|
      puts "#{number}. #{artist.name}"
      number += 1
    }
  end
  
  def list_genres
    number = 1
    @current_list = sort_data(Genre.all)
    @current_list.each { |genre|
      puts "#{number}. #{genre.name}"
      number += 1
    }
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    name = gets.strip
    artist = Artist.find_or_create_by_name(name)
    number = 1
    @current_list = sort_data(artist.songs)
    @current_list.each { |song|
      puts "#{number}. #{song.name} - #{song.genre.name}"
      number += 1
    }
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    name = gets.strip
    genre = Genre.find_or_create_by_name(name)
    number = 1
    @current_list = sort_data(genre.songs)
    @current_list.each { |song|
      puts "#{number}. #{song.artist.name} - #{song.name}"
      number += 1
    }
  end
  
  def play_song
    puts "Which song number would you like to play?"
    index = gets.strip.to_i - 1
    if @current_list[index] && index >= 0 && index < @current_list.size
      puts "Playing #{@current_list[index].name} by #{@current_list[index].artist.name}"
    end
  end
  
  def sort_data(data)
    return data.sort { |datum_a, datum_b| datum_a.name <=> datum_b.name }
  end
end
