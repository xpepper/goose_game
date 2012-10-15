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

class RandomSequence

  def sequence_of_length(sequence_length)
    sequence = []
    sequence_length.times { sequence << (1 + rand(6)) }
    sequence
  end
end

class Array
  def sum
    inject(0, &:+)
  end
end