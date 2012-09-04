class Player
  attr_reader :name
  
  def initialize(name)
    @name = name
    @position = 0
  end
  
  def position
    @position == 0 ? "Partenza" : @position
  end
  
  def move(moves)
    @position += moves
  end
  
  def ==(other)
    return false unless self.class == other.class
    return true if self.name == other.name
  end
  
end