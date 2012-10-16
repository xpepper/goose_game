require_relative "patches/array"

class Dice

  def initialize(*dice)
    if dice.empty?
      dice = RandomSequence.new.sequence_of_length(2)
    end

    @dice = dice
  end

  def sum
    @dice.sum
  end

  def say_rolls
    @dice.join(', ')
  end

end
