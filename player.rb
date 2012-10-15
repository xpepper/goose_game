class Player
  attr_reader :name

  def initialize(name)
    @name = name
    @positions = [0]
  end

  def position
    return 63 if bounced?

    say(@positions.last)
  end

  def bounced_position
    @bounced = false if bounced?
    position
  end

  def previous_position
    say(@positions[-2])
  end

  def move(step)
    new_position = @positions.last + step
    if should_bounce?(new_position)
      new_position = bounces(new_position)
      @bounced = true
    else
      @bounced = false
    end

    @positions << new_position
  end

  def wins?
    @positions.last == 63
  end

  def bounced?
    @bounced
  end

  def ==(other)
    return false unless self.class == other.class
    return true if self.name == other.name
  end


  private

  def should_bounce?(position)
    position > 63
  end

  def bounces(new_position)
    63 - new_position % 63
  end

  def say(position)
    position == 0 ? "Partenza" : position
  end
end
