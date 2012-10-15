# encoding: UTF-8

require 'rubygems'
require 'rspec'

require_relative '../dice'

describe Dice do

  describe "#sum" do
    it "sums the dice" do
      Dice.new(1,2).roll.should == 3
    end
  end

  describe "#say_rolls" do
    it "says the dice rolls as a string" do
      Dice.new(1,2,3,4).say_rolls.should == "1, 2, 3, 4"
    end
  end

  describe "#initialize" do
    it "build a random dice rolls when the dice rolls is not given" do
      Dice.any_instance.stub(:sequence_builder).and_return(stub(sequence_of_length: [1,2]))
      dice = Dice.new

      dice.roll.should == 3
    end

  end

end
