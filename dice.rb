require_relative "patches/array"

class Dice

  def initialize(*dice)
    if dice.nil? || dice.empty?
      dice = sequence_builder.sequence_of_length(2)
    end

    @dice ||= dice
  end

  def roll
    @dice.sum
  end

  def say_rolls
    @dice.join(', ')
  end

  def sequence_builder
    RandomSequence.new
  end

  def method_name
    raise "no!"
  end

end
