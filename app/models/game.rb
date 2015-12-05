class Game < ActiveRecord::Base
  has_many :pieces
  has_many :join_games
  has_many :joined_players, through: :join_games, source: :player
  belongs_to :players

  def in_check?(color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    color == true ? enemy_color = false : enemy_color = true
    enemies = Piece.where(color: enemy_color , game_id: id)

    enemies.each do |enemy|
      if enemy.legal_move?(king.x_position, king.y_position)
	@enemy_making_check = enemy
	return true
      end
    end
    false
  end

  def captured_pieces(x, y, board)
    self.dead_pieces << [board.board[y][x].type, board.board[y][x].color]
    self.save!
  end

  def in_checkmate?
    # Checks to see if either player is in checkmate.
  end

  def player_turn
    # Checks to see who's turn it is.
  end

  def check_two_players_present
    # Checks that two players are present(logged in) to play.
  end

end
