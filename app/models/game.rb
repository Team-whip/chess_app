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
        enemy_making_check = enemy
        in_check = true
      end
    end
    in_check
  end

  def moving_into_check?(x, y, color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    enemies = enemies(color)
    in_check = false

    enemies.each do |enemy|
      if enemy.legal_move?(x, y)
        enemy_making_check = enemy
        in_check = true
      end
    end
    in_check
  end

  def is_move_on_board?(x, y, game_id)
    king = Piece.find_by(type: 'King', x_position: x, y_position: y, game_id: id )
    on_board = false

    if x >= 0 && x <= 7 && y >= 0 && y <= 7
      on_board = true
    else
      false
    end

  end

  def can_move_out_of_check?(color, game_id)
    king = Piece.find_by(type: 'King', color: color, game_id: game_id )
    puts 1
    move_out_check = false
    puts 2

    x = king.x_position - 1
    y = king.y_position

  ##((king.x_position - 1)..(king.x_position + 1)).each do |x|
    ##((king.y_position - 1 )..(king.y_position + 1)).each do |y|
      ##puts 3
        #if is_move_on_board?(x, y, game_id)
          puts 4
          if moving_into_check?(x, y, color) == false
            move_out_check = true
            return move_out_check
            puts 5
          end
        #end
      ##end
    ##end
    move_out_check
    puts 6
  end

  def can_be_captured?(color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    enemies = enemies(color)
    allies = enemies(!color)
    capture = false

    enemies.each do |enemy|
      if enemy.legal_move?(king.x_position, king.y_position)
        @enemy_making_check = enemy
      end
    end

    allies.each do |ally|
      if ally.legal_move?(@enemy_making_check.x_position, @enemy_making_check.y_position)
        capture = true
      end
    end
    capture
  end

  def can_be_blocked?(color, board)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    enemies = enemies(color)
    allies = enemies(!color)
    block = false

    enemies.each do |enemy|
      if enemy.legal_move?(king.x_position, king.y_position)
        @enemy_making_check = enemy
      end
    end

    x_diff = (@enemy_making_check.x_position - king.x_position).abs
    y_diff = (@enemy_making_check.y_position - king.y_position).abs

    if @enemy_making_check.x_position - king.x_position > 0
      enemy_x_greater = true
    elsif @enemy_making_check.x_position - king.x_position < 0
      enemy_x_lesser = true
    elsif @enemy_making_check.x_position - king.x_position = 0
      enemy_x_same = true
    end

    if @enemy_making_check.y_position - king.y_position > 0
      enemy_y_greater = true
    elsif @enemy_making_check.y_position - king.y_position < 0
      enemy_y_lesser = true
    elsif @enemy_making_check.y_position - king.y_position = 0
      enemy_y_same = true
    end

    allies.each do |ally|
      if enemy_x_greater && enemy_y_greater
        while x_diff > 0
          while y_diff > 0
            if ally.legal_move?(@enemy_making_check.x_position - x_diff, @enemy_making_check.y_position - y_diff)
              block = true
            end
          y_diff -= 1
          end
        x_diff -= 1
        end   
      elsif enemy_x_same && enemy_y_greater
        while y_diff > 0
          if ally.legal_move?(@enemy_making_check.x_position, @enemy_making_check.y_position - y_diff)
            block = true
          end
          y_diff -= 1 
        end
      elsif enemy_x_lesser && enemy_y_greater
        while x_diff > 0
          while y_diff > 0
            if ally.legal_move?(@enemy_making_check.x_position + x_diff, @enemy_making_check.y_position - y_diff)
              block = true
            end
            y_diff -= 1
          end
          x_diff -=1
        end

      end
    end
    block
  end

  def checkmate?(color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )

    return false unless in_check?(color)

    return false if king.can_move_out_of_check?

    return false if can_be_captured?

    return false if can_be_blocked?

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
        black_queen_rook.update_attributes(x_position: 3, moved: true)
      elsif x < king.x_position && king.color == true
        white_queen_rook = Piece.find_by(x_position: 0, y_position: 7, type: 'Rook', color: color, game_id: game_id)
        white_queen_rook.update_attributes(x_position: 3, moved: true)
      end
    else
      return false
   end  
  end
end
