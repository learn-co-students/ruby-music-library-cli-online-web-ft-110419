
module Concerns::Findable
    def find_by_name(name)
        self.all.select {|x| x.name == name}[0]
    end

    def find_or_create_by_name(name)
        if self.find_by_name(name) == nil
            self.create(name)
        else
            self.find_by_name(name)
        end
    end
end
