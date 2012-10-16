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

  def move(player, *dice_roll)
    raise Exception.new("#{player.name} is not playing in this game") unless is_playing?(player)

    dice = Dice.new(*dice_roll)
    step = dice.sum

    player.move(step)

    message = "#{player.name} tira #{dice.say_rolls}. #{player.name} muove da #{player.previous_position} a #{player.position}"
    message << ". #{player.name} vince!!" if player.wins?
    message << ". #{player.name} Rimbalza! Pippo torna a #{player.bounced_position}" if player.bounced?

    player.post_move_actions

    message << ". #{player.name} salta al #{Player::BRIDGE_SQUARE}" if player.jumped_on_bridge?
    message << ", oca. #{player.name} muove di nuovo e va a #{player.position}" if player.jumped_on_goose?

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
