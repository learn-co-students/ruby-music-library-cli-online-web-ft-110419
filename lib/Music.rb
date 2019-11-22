class Music 
  attr_accessor :name 
  @@all = []
  
  def initialize(name)
    @name = name 
  end
  
  def save
    @@all << self 
  end
  
  def self.all 
    @@all 
  end
  
  def self.create(name)
    new = self.new(name) 
    new.save 
    new
  end
  
  def self.destroy_all
    @@all = []
  end
end