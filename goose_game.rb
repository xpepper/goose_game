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

  def move(player, *dice)
    raise Exception.new("#{player.name} is not playing in this game") unless is_playing?(player)

    player.move(dice.sum)

    message = "#{player.name} tira #{dice.join(', ')}. #{player.name} muove da #{player.previous_position} a #{player.position}"
    message << ". #{player.name} vince!!" if player.wins?
    message << ". #{player.name} Rimbalza! Pippo torna a #{player.bounced_position}" if player.bounced?
    
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

class Array
  def sum
    inject(0, &:+) 
  end
end