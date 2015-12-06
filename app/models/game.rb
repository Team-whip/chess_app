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

  def moving_in_to_check?(x, y, color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    color == true ? enemy_color = false : enemy_color = true
    enemies = Piece.where(color: enemy_color , game_id: id)

    enemies.each do |enemy|
      if enemy.legal_move?(x, y)
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

  def legal_castle_move?(x, y, color, game_id)
    king = Piece.find_by(type: 'King', color: color, game_id: game_id)

    #return false if king has moved
    if king.color == false
      return false unless king.x_position == 4 && king.y_position == 0
      black_king = king
    else
      return false unless king.x_position == 4 && king.y_position == 7
      white_king = king
    end

    #there are no pieces between the king and chosen rook
    #this will be handled by pushing this through the attempt_move which checks for obstructions

    #the king is not in check
    #this will be handled by pushing this through attempt_move which checks for in_check?

    #check that intent is to castle
    return false unless (x - king.x_position).abs == 2
    return false unless y == king.y_position

    #check which side rook the castling will occur on and return false if rook has moved
    #or been captured

    if x > king.x_position && king.color == false
      black_king_rook = Piece.find_by(x_position: 7, y_position: 0, type: 'Rook', color: color, game_id: game_id)
      return false if black_king_rook == nil
    elsif x > king.x_position && king.color == true
      white_king_rook = Piece.find_by(x_position: 7, y_position: 7, type: 'Rook', color: color, game_id: game_id)
      return false if white_king_rook == nil
    elsif x < king.x_position && king.color == false
      black_queen_rook = Piece.find_by(x_position: 0, y_position: 0, type: 'Rook', color: color, game_id: game_id)
      return false if black_queen_rook == nil
    elsif x < king.x_position && king.color == true
      white_queen_rook = Piece.find_by(x_position: 0, y_position: 7, type: 'Rook', color: color, game_id: game_id)
      return false if white_queen_rook == nil
    else
      return false
    end    
    true
  end

  def castling_occured(x, y, board, color, game_id)
    king = Piece.find_by(type: 'King', color: color, game_id: game_id)

    if king.king_legal_move?(x, y, color, game_id) == true && king.is_move_obstructed?(x, y, board) == false
      castling = true
    else
      castling = false
    end

    if castling == true
      if x > king.x_position && king.color == false
        black_king_rook = Piece.find_by(x_position: 7, y_position: 0, type: 'Rook', color: color, game_id: game_id)
        black_king_rook.update_attributes(x_position: 5)
      elsif x > king.x_position && king.color == true
        white_king_rook = Piece.find_by(x_position: 7, y_position: 7, type: 'Rook', color: color, game_id: game_id)
        white_king_rook.update_attributes(x_position: 5)
      elsif x < king.x_position && king.color == false
        black_queen_rook = Piece.find_by(x_position: 0, y_position: 0, type: 'Rook', color: color, game_id: game_id)
        black_queen_rook.update_attributes(x_position: 2)
      elsif x < king.x_position && king.color == true
        white_queen_rook = Piece.find_by(x_position: 0, y_position: 7, type: 'Rook', color: color, game_id: game_id)
        white_queen_rook.update_attributes(x_position: 2)
      end
    else
      return false
  end  

  end

end
