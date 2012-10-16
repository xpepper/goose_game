class Player
  attr_reader :name

  BRIDGE_SQUARE = 12
  VICTORY_SQUARE = SQUARE_COUNT = 63

  def initialize(name)
    @name = name
    @positions = [0]
  end

  def move(step)
    new_position = @positions.last + step

    @bounced = should_bounce?(new_position)
    new_position = bounces(new_position) if bounced?

    @positions << new_position
  end

  def bounced_position
    @bounced = false if bounced?
    position
  end

  def position
    return VICTORY_SQUARE if bounced?

    say(@positions.last)
  end

  def previous_position
    say(@positions[-2])
  end

  def wins?
    @positions.last == VICTORY_SQUARE
  end

  def bounced?
    @bounced
  end

  def on_bridge?
    @positions.last == 6
  end

  def jumped_on_bridge?
    @positions.last == BRIDGE_SQUARE
  end

  def post_move_actions
    move(6) if on_bridge?
  end

  def ==(other)
    return false unless self.class == other.class
    return true if self.name == other.name
  end


  private

  def should_bounce?(position)
    position > VICTORY_SQUARE
  end

  def bounces(new_position)
    SQUARE_COUNT - new_position % SQUARE_COUNT
  end

  def say(position)
    position_map = { 0 => "Partenza", 6 => "Il Ponte" }
    position_map[position] || position
  end
end
