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

  def is_move_on_board?(x, y)
    king = Piece.find_by(type: 'King', x_position: x, y_position: y, game_id: id )
    on_board = false

    if x >= 0 && x <= 7 && y >= 0 && y <= 7
      on_board = true
    else
      false
    end

  end

  def can_move_out_of_check?(color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )

  ((king.x_position - 1)..(king.x_position + 1)).each do |x|
    ((king.y_position - 1 )..(king.y_position + 1)).each do |y|
        if is_move_on_board?(x, y)
          unless moving_into_check?(x, y, color)
            return true
          else
            false
          end
        else 
          false
        end
      end
    end
    false
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

    if allies != nil
      allies.each do |ally|
        if ally.legal_move?(@enemy_making_check.x_position, @enemy_making_check.y_position)
          capture = true
        end
      end
    end
    capture
  end

  def obstruction_array(enemy_x, enemy_y, color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    pos_x = king.x_position
    pos_y = king.y_position
  
    if enemy_x == pos_x || enemy_y == pos_y
      rectilinear_obstruction_array(enemy_x, enemy_y, color)
    else
      diagonal_obstruction_array(enemy_x, enemy_y, color)
    end
  end

  def diagonal_obstruction_array(enemy_x, enemy_y, color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    pos_x = king.x_position
    pos_y = king.y_position

    obstruction_array = []

    return [] if enemy_x == pos_x
    return [] if enemy_y == pos_y

    horizontal_increment = enemy_x > pos_x ? 1 : -1
    vertical_increment = enemy_y > pos_y ? 1 : -1

    pos_x += horizontal_increment
    pos_y += vertical_increment

    while (enemy_x - pos_x).abs > 0 && (enemy_y - pos_y).abs > 0
      obstruction_array << [pos_x, pos_y]
      pos_x += horizontal_increment
      pos_y += vertical_increment
    end
    obstruction_array
  end

  def rectilinear_obstruction_array(enemy_x, enemy_y, color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    pos_x = king.x_position
    pos_y = king.y_position

    obstruction_array = []

    if enemy_y == pos_y 
      horizontal_increment = enemy_x > pos_x ? 1 : -1
      pos_x += horizontal_increment

      while (enemy_x - pos_x).abs > 0
        obstruction_array << [pos_x, pos_y]
        pos_x += horizontal_increment
      end
    elsif enemy_x == pos_x
      vertical_increment = enemy_y > pos_y ? 1 : -1
      pos_y += vertical_increment

      while (enemy_y - pos_y).abs > 0
        obstruction_array << [pos_x, pos_y]
        pos_y += vertical_increment
      end
    end
    obstruction_array
  end

  def can_be_blocked?(enemy_x, enemy_y, color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    enemies = enemies(color)
    allies = enemies(!color)

    obstruction = obstruction_array(enemy_x, enemy_y, color)

    if allies != nil
      allies.each do |ally|
        next if ally == king
        obstruction.each do |square|
          return true if ally.legal_move?(square[0], square[1])
        end
      end
    end
    false
  end

  def multiple_checks?(color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    enemies = enemies(color)
    allies = enemies(!color)

    multiple_checks = false

    count = 0
    while count < 3 do 
      enemies.each do |enemy|     
        if enemy.legal_move?(king.x_position, king.y_position)
          @enemy_making_check = enemy
          count += 1
        end
      end

      if count > 3
        multiple_checks = true
      end
    end
    multiple_checks
  end

  def enemy_path(color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )
    enemies = enemies(color)

    obstruction_array = []

    enemies.each do |enemy|
      if enemy.legal_move?(king.x_position, king.y_position)
        obstruction_array << [enemy.x_position, enemy.y_position]
      end
    end
    obstruction_array.first
  end

  def checkmate?(color)
    king = Piece.find_by(type: 'King', color: color, game_id: id )

    return false unless in_check?(color)

    return false if can_move_out_of_check?(color)

    return false if can_be_captured?(color)

    if multiple_checks?(color) == false
      return false if can_be_blocked?(enemy_path[0], enemy_path[1], color)
    elsif multiple_checks?(color) == true
      return true
    end
    true
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
