class Music 
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def self.create(name)
    instance = self.new(name)
    instance.save
    instance
  end

end