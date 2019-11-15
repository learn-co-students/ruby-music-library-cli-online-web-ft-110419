module Concerns::Findable
  def find_by_name(name)
    return all.detect { |object| object.name == name }
  end
  
  def find_or_create_by_name(name)
    return find_by_name(name) if find_by_name(name)
    return create(name)
  end
end
