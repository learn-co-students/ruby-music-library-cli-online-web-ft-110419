class Artist < Music
  
  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end
end