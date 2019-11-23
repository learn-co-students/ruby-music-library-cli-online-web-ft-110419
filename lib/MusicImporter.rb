class MusicImporter
  attr_accessor :path
  
  def initialize(file_path)
    @path = file_path
  end 
  
  def files 
    files = Dir.entries(@path)
    #select all mp3s
    files = files.select{|file| file[-4..-1] == ".mp3"}
  end 
  
  def import 
    files = self.files
    files.each do |file|
      Song.create_from_filename(file)
    end
    # #delete ".mp3" from the end of each title
    # files = files.map{|file| file[0..-5]}
    # files.split(" - ")
    # files.each do |file|
    #   song = Song.new
    #   song.artist = file[0]
    #   song.name = file[1]
    #   song.genre = file[2]
    #   p song
  end
  
end 

