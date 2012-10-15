class RandomSequence

  def sequence_of_length(sequence_length)
    sequence = []
    sequence_length.times { sequence << (1 + rand(6)) }
    sequence
  end

end
