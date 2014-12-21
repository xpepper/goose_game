# encoding: UTF-8

require_relative '../dice'
require_relative "../random_sequence"

describe Dice do

  describe "#sum" do
    it "sums the dice" do
      expect(Dice.new(1,2).sum).to eq(3)
    end
  end

  describe "#say_rolls" do
    it "says the dice rolls as a string" do
      expect(Dice.new(1,2,3,4).say_rolls).to eq("1, 2, 3, 4")
    end
  end

  describe "#initialize" do
    it "build a random dice rolls when the dice rolls is not given" do
      allow_any_instance_of(RandomSequence).to receive(:sequence_of_length).and_return([4,5])
      dice = Dice.new

      expect(dice.sum).to eq(4+5)
    end

  end

end
