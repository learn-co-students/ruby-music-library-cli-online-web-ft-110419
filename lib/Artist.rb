class Artist
    attr_accessor :name, :song
    @@all =[]
    def initialize(name)
      @name = name
      @songs = []
    end
    def name
        @name
    end

    def name=(name)
      @name = name
    end

      def self.all
         @@all
      end
      def self.destroy_all 
        @@all.clear
      end
      def save
        @@all << self unless @@all.include?(self)
      end

      def self.create(song)
        song = self.new(song)
        song.save
        song
      end

      def songs
        @songs
      end
    
    end