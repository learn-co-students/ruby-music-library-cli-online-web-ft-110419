class Genre < Music 
  extend Concerns::Findable
  attr_reader :songs
  
  def initialize(name)
    super 
    @songs = []
  end
  
  def artists 
    songs.map{|song| song.artist}.uniq
  end
end