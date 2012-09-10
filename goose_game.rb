# encoding: UTF-8

class GooseGame

  def initialize
    @players = []
  end

  def add_player(player)
    return already_present(player) if is_playing?(player)

    @players << player
    "Giocatori: #{@players.map(&:name).join(', ')}"
  end

  def move(player, dice1, dice2)
    raise Exception.new("#{player.name} is not playing in this game") unless is_playing?(player)

    current_position = player.position
    player.move(dice1 + dice2)

    message = "#{player.name} tira #{dice1}, #{dice2}. #{player.name} muove da #{current_position} a #{player.position}"
    message << ". #{player.name} vince!!" if player.wins?

    message
  end

  private

  def is_playing?(player)
    @players.include?(player)
  end

  def already_present(player)
    "#{player.name}: giocatore già presente"
  end
end
