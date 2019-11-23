require 'bundler'
Bundler.require
require_relative "../lib/Music.rb"

module Concerns
  module Findable
    def find_by_name(name)
      self.all.find{|song| song.name == name}
    end 
  
    def find_or_create_by_name(name)
      found = find_by_name(name)
      if found
        return found 
      else 
        self.create(name)
      end
    end
  end
end

require_all 'lib'
