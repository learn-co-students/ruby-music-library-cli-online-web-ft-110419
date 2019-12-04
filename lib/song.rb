class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist= nil, genre= nil)
    @name = name
    self.artist= artist if artist
    self.genre= genre if genre
    save
  end

  def self.all
    @@all.uniq
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    self.new(name)
  end

  def artist=(name)
    @artist = name
    artist.songs << self if !artist.songs.include?(self)
    artist.add_song(self)
  end

  def genre=(name)
    @genre = name
    genre.songs << self if !genre.songs.include?(self)
  end

  def self.find_by_name(songName)
      all.find {|song| song.name == songName}
    end

  def self.find_or_create_by_name(name)
    if find_by_name(name)
      return find_by_name(name)
    else
      create(name)
    end
  end
  def self.new_from_filename(name)
     artist, song, genre = name.split(' - ')
     fixed_name = genre.gsub('.mp3','')
     artist = Artist.find_or_create_by_name(artist)
     genre = Genre.find_or_create_by_name(fixed_name)
     new(song, artist, genre)
   end

   def self.create_from_filename(name)
     new_from_filename(name).save
   end

end#end of class
