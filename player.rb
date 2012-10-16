class Player
  attr_reader :name

  BRIDGE_SQUARE = 12
  VICTORY_SQUARE = SQUARE_COUNT = 63

  def initialize(name)
    @name = name
    @positions = [0]
  end

  def move(step)
    @step = step
    new_position = current_position + @step

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

    say(current_position)
  end

  def previous_position
    say(@positions[-2])
  end

  def wins?
    current_position == VICTORY_SQUARE
  end

  def bounced?
    @bounced
  end

  def on_bridge?
    @on_bridge = current_position == 6

    @on_bridge
  end

  def jumped_on_bridge?
    jumped_on_bridge = @on_bridge.nil? ? false : @on_bridge
    @on_bridge = false
    jumped_on_bridge
  end

  def post_move_actions
    move(6) if on_bridge?
    move(last_step) if on_goose?
  end

  def on_goose?
    [5, 9, 14, 23, 27, 32, 36, 41, 45, 50, 54, 59].include?(current_position)
  end

  def jumped_on_goose?
    [5, 9, 14, 23, 27, 32, 36, 41, 45, 50, 54, 59].include?(@positions[-2])
  end

  def ==(other)
    return false unless self.class == other.class
    return true if self.name == other.name
  end
  
  private
  
  def current_position
    @positions.last
  end

  def last_step
    @step || 0
  end

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
