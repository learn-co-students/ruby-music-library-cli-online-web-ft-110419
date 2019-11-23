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
  end
  
end 

