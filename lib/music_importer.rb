class MusicImporter
  
  attr_reader :path
  
  def initialize(path)
    @path = path
  end
  
  def files
    @files ||= Dir.glob("#{path}/*.mp3").map{|file| file.sub("#{path}/", "")}
  end
  
  def import 
    files.each do |f|
      Song.create_from_filename(f)
    end
  end
  
end