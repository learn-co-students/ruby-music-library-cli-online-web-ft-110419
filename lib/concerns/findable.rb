module Concerns
    module Findable

        def find_by_name(name)
            self.all.find{|element| element.name == name}
        end

        def find_or_create_by_name(name)
            find_by_name(name) || create(name)
        end
    end
end

class Artist
    extend Concerns::Findable
end

class Genre
    extend Concerns::Findable
end