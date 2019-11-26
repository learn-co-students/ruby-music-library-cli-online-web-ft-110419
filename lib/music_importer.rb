
class MusicImporter
  
  attr_accessor :path
  
  def initialize(file_path)
    @path = file_path
  end
  
  def files
    Dir.entries(self.path).grep(/.+\.mp3\b/)
  end
  
  def import 
    files.each {|file_name| Song.create_from_filename(file_name)}
  end
  
end