# encoding: UTF-8

require 'rubygems'
require 'rspec'

require_relative '../goose_game'
require_relative '../player'

describe GooseGame do

  let(:game) { GooseGame.new }
  let(:pippo) { Player.new("Pippo") }
  let(:pluto) { Player.new("Pluto") }

  context "Adding players" do

    it "adds a single player" do
      result = game.add_player(pippo)
      result.should == "Giocatori: Pippo"
    end

    it "adds more players" do
      game.add_player(pippo)

      result = game.add_player(pluto)
      result.should == "Giocatori: Pippo, Pluto"
    end

    it "tells when adding an already present player" do
      game.add_player(pippo)

      result = game.add_player(pippo)
      result.should == "Pippo: giocatore già presente"
    end
  end

  context "Moving players" do
    it "throws exception when trying to move an unexisting player" do
      lambda { game.move(pippo, 4,2) }.should raise_error(Exception, "Pippo is not playing in this game")
    end

    it "moves a player from start" do
      game.add_player(pippo)

      game.move(pippo, 4,2).should == "Pippo tira 4, 2. Pippo muove da Partenza a 6"
    end

    it "moves a player" do
      game.add_player(pippo)

      game.move(pippo, 4,2).should == "Pippo tira 4, 2. Pippo muove da Partenza a 6"
      game.move(pippo, 2,3).should == "Pippo tira 2, 3. Pippo muove da 6 a 11"
    end
  end

  context "Winning" do
    it "lets win the player who reaches 63" do
      game.add_player(pippo)
      game.move(pippo, 60, 0)

      game.move(pippo, 1, 2).should == "Pippo tira 1, 2. Pippo muove da 60 a 63. Pippo vince!!"
    end
  end

  context "Bounce" do
    it "bounces the player who exceeds 63" do
      game.add_player(pippo)
      game.move(pippo, 60, 0)

      game.move(pippo, 3, 2).should == "Pippo tira 3, 2. Pippo muove da 60 a 63. Pippo Rimbalza! Pippo torna a 61"
    end
  end

end
