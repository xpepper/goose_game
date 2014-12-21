# encoding: UTF-8

require 'rubygems'
require 'rspec'

require_relative '../player'

describe Player do
  let(:player) { Player.new("a_player") }

  describe "#wins?" do
    it "wins when player is in square 63" do
      player.move(63)

      expect(player.wins?).to be_truthy
    end
  end
  
  describe "#position" do
    it "tells the player position" do
      player.move(23)

      expect(player.position).to eq(23)
    end
  end
  
end
