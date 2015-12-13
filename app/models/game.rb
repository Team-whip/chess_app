class Game < ActiveRecord::Base
  has_many :pieces
  has_many :join_games
  has_many :joined_players, through: :join_games, source: :player
  belongs_to :players

  def in_check?(color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    enemies = enemies(color)
    in_check = false

    enemies.each do |enemy|
      if enemy.legal_move?(king.x_position, king.y_position)
        @enemy_making_check = enemy
        in_check = true
      end
    end
    in_check
  end

  def moving_in_to_check?(x, y, color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    enemies = enemies(color)
    in_check = false

    enemies.each do |enemy|
      if enemy.legal_move?(x, y)
        @enemy_making_check = enemy
        in_check = true
      end
    end
    in_check
  end

  def can_move_out_of_check?(color, game_id)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    #puts 1
    success = false
    #puts 2

  ((king.x_position - 1)..(king.x_position + 1)).each do |x|
    ((king.y_position - 1 )..(king.y_position + 1)).each do |y|
      #puts 3
        if king.legal_move?(x, y)
          #puts 4
          if moving_in_to_check?(x, y, color) == false
            success = true
            #puts 5
          end
        end
      end
    end
    success
    #puts 6
  end

  def checkmate?(color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )

    return false unless in_check?(color)

    return false if king.can_move_out_of_check?

    # See if another piece can capture checking piece

    # See if another piece can block check

  end

  def enemies(color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    color == true ? enemy_color = false : enemy_color = true
    enemies = Piece.where(color: enemy_color , game_id: id)
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

    if king.color == false
      if king.x_position == 4
        if king.y_position == 0
          black_king = king
        else
          return false
        end
      else
        return false
      end
      if black_king.moved
        return false
      end
    else
      if king.x_position == 4
        if king.y_position == 7
          white_king = king
        else
          return false
        end
      else
        return false
      end
      if white_king.moved
        return false
      end
    end

    if (x - king.x_position).abs == 2
      if y != king.y_position
        return false
      end
    else
      return false
    end

    if x > king.x_position && king.color == false
      black_king_rook = Piece.find_by(x_position: 7, y_position: 0, type: 'Rook', color: color, game_id: game_id)
      if black_king_rook == nil
        return false
      elsif black_king_rook.moved
        return false
      else
        return true
      end
    elsif x > king.x_position && king.color == true
      white_king_rook = Piece.find_by(x_position: 7, y_position: 7, type: 'Rook', color: color, game_id: game_id)
      if white_king_rook == nil
        return false
      elsif white_king_rook.moved 
        return false
      else
        return true
      end
    elsif x < king.x_position && king.color == false
      black_queen_rook = Piece.find_by(x_position: 0, y_position: 0, type: 'Rook', color: color, game_id: game_id)
      if black_queen_rook == nil
        return false
      elsif black_queen_rook.moved 
        return false
      else
        return true
      end
    elsif x < king.x_position && king.color == true
      white_queen_rook = Piece.find_by(x_position: 0, y_position: 7, type: 'Rook', color: color, game_id: game_id)
      if white_queen_rook == nil
        return false
      elsif white_queen_rook.moved
        return false
      else
        return true
      end
    else
      return false
    end  
  end

  def castling_occured(x, y, color, game_id)
    king = Piece.find_by(type: 'King', color: color, game_id: game_id)
    
    if self.legal_castle_move?(x, y, color, game_id)
      castling = true
    else
      castling = false
    end

    if castling == true
      if x > king.x_position && king.color == false
        black_king_rook = Piece.find_by(x_position: 7, y_position: 0, type: 'Rook', color: color, game_id: game_id)
        black_king_rook.update_attributes(x_position: 5, moved: true)
      elsif x > king.x_position && king.color == true
        white_king_rook = Piece.find_by(x_position: 7, y_position: 7, type: 'Rook', color: color, game_id: game_id)
        white_king_rook.update_attributes(x_position: 5, moved: true)
      elsif x < king.x_position && king.color == false
        black_queen_rook = Piece.find_by(x_position: 0, y_position: 0, type: 'Rook', color: color, game_id: game_id)
        black_queen_rook.update_attributes(x_position: 2, moved: true)
      elsif x < king.x_position && king.color == true
        white_queen_rook = Piece.find_by(x_position: 0, y_position: 7, type: 'Rook', color: color, game_id: game_id)
        white_queen_rook.update_attributes(x_position: 2, moved: true)
      end
    else
      return false
   end  
  end
end
