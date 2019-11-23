class MusicLibraryController
  # extend Concerns::Findable

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    user_input = nil
    until user_input == "exit"
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
        when "list songs"
          self.list_songs
        when "list artists"
          self.list_artists
        when "list genres"
          self.list_genres
        when "list artist"
          self.list_songs_by_artist
        when "list genre"
          self.list_songs_by_genre
        when "play song"
          self.play_song
      end
    end
  end

  def list_songs
    self.sort_songs.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted_artists = Artist.all.sort_by { |artist| artist.name }
    sorted_artists.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist.name}"
    end
  end

  def list_genres
    sorted_genres = Genre.all.sort_by { |genre| genre.name }
    sorted_genres.each.with_index(1) do |genre, index|
      puts "#{index}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.strip
    artist = Artist.find_by_name(user_input)
    if artist
      songs = Song.all.select { |s| s.artist == artist }.sort_by { |song| song.name }.uniq
      songs.each.with_index(1) { |s, i| puts "#{i}. #{s.name} - #{s.genre.name}" }
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.strip
    genre = Genre.find_by_name(user_input)
    if genre
      songs = Song.all.select { |s| s.genre.name == user_input }.uniq
      songs.sort_by! { |s| s.name }
      songs.each.with_index(1) { |s, i| puts "#{i}. #{s.artist.name} - #{s.name}" }
    end
  end

  def sort_songs
    Song.all.sort_by { |song| song.name }.uniq
  end
  def print_song_names
    songs = self.sort_songs
    songs.each { |s| puts s.name }
  end
  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.strip.to_i

    if user_input.between?(1, Song.all.uniq.length)
      song = self.sort_songs[user_input - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end