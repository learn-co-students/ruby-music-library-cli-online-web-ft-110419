class Artist < Music 
  extend Concerns::Findable 
  attr_accessor :songs
  
  def initialize(name)
    super 
    @songs = []
  end
  
  def add_song(song)
    if !song.artist
      song.artist = self
    end
    if !@songs.include?(song)
      @songs << song
    end
  end
  
  def genres 
    @songs.map{|song| song.genre}.uniq
  end
end