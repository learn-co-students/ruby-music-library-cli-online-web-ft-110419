class MusicImporter
  attr_reader :path
  
  def initialize(path)
    @path = path
    @files = Dir["#{path}/**/*.mp3"]
  end
  
  def files
    i = 0
    while i < @files.size do
      @files[i] = @files[i].split('/').last
      i += 1
    end
    return @files
  end
  
  def import
    self.files.each { |file| Song.create_from_filename(file) }
  end
end
