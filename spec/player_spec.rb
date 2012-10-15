# encoding: UTF-8

require 'rubygems'
require 'rspec'

require_relative '../player'

describe Player do
  let(:player) { Player.new("a_player") }

  describe "#wins?" do
    it "wins when player is in square 63" do
      player.move(63)

      player.wins?.should be_true
    end
  end
  
  describe "#position" do
    it "tells the player position" do
      player.move(23)

      player.position.should == 23
    end
  end
  
end
