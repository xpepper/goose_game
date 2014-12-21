# encoding: UTF-8

require_relative '../goose_game'
require_relative '../player'
require_relative '../dice'
require_relative '../random_sequence'

describe GooseGame do

  let(:game)  { GooseGame.new }
  let(:pippo) { Player.new("Pippo") }
  let(:pluto) { Player.new("Pluto") }

  context "Adding players" do

    it "adds a single player" do
      result = game.add_player(pippo)
      expect(result).to eq("Giocatori: Pippo")
    end

    it "adds more players" do
      game.add_player(pippo)

      result = game.add_player(pluto)
      expect(result).to eq("Giocatori: Pippo, Pluto")
    end

    it "tells when adding an already present player" do
      game.add_player(pippo)

      result = game.add_player(pippo)
      expect(result).to eq("Pippo: giocatore già presente")
    end
  end

  context "Moving players" do
    it "throws exception when trying to move an unexisting player" do
      expect { game.move(pippo, 4,2) }.to raise_error(Exception, "Pippo is not playing in this game")
    end

    it "moves a player from start" do
      game.add_player(pippo)

      expect(game.move(pippo, 4,3)).to eq("Pippo tira 4, 3. Pippo muove da Partenza a 7")
    end

    it "moves a player" do
      game.add_player(pippo)

      expect(game.move(pippo, 4,3)).to eq("Pippo tira 4, 3. Pippo muove da Partenza a 7")
      expect(game.move(pippo, 2,2)).to eq("Pippo tira 2, 2. Pippo muove da 7 a 11")
    end
  end

  context "Winning" do
    it "lets win the player who reaches 63" do
      game.add_player(pippo)
      game.move(pippo, 60)

      expect(game.move(pippo, 1, 2)).to eq("Pippo tira 1, 2. Pippo muove da 60 a 63. Pippo vince!!")
    end
  end

  context "Bounce" do
    it "bounces the player who exceeds 63" do
      game.add_player(pippo)
      game.move(pippo, 60, 0)

      expect(game.move(pippo, 3, 2)).to eq("Pippo tira 3, 2. Pippo muove da 60 a 63. Pippo Rimbalza! Pippo torna a 61")
    end
  end

  context "Game auto-play feature" do
    before(:each) do
      allow_any_instance_of(RandomSequence).to receive(:sequence_of_length).and_return([1, 2])
    end

    it "throws the dice for the player" do
      game.add_player(pippo)
      game.move(pippo, 4)

      expect(game.move(pippo)).to eq("Pippo tira 1, 2. Pippo muove da 4 a 7")
    end
  end

  context "Square 6 is 'the bridge'" do
    before(:each) do
      allow_any_instance_of(RandomSequence).to receive(:sequence_of_length).and_return([1, 1])
    end

    it "moves the player from square 6 directly to square 12" do
      game.add_player(pippo)
      game.move(pippo, 4)

      expect(game.move(pippo)).to eq("Pippo tira 1, 1. Pippo muove da 4 a Il Ponte. Pippo salta al 12")
    end

    it "does something" do
      game.add_player(pippo)

      game.move(pippo, 10)
      expect(game.move(pippo, 1,1)).to eq("Pippo tira 1, 1. Pippo muove da 10 a 12")
    end
  end

  context "Goose squares" do
    before(:each) do
      allow_any_instance_of(RandomSequence).to receive(:sequence_of_length).and_return([1, 1])
    end

    it "let the player move again by the same step he just made" do
      game.add_player(pippo)
      game.move(pippo, 3)

      expect(game.move(pippo)).to eq("Pippo tira 1, 1. Pippo muove da 3 a 5, oca. Pippo muove di nuovo e va a 7")

    end
  end
end
