class Pawn < Piece
  def legal_move?(x, y)
    if (x == x_position + 1 && y == y_position + 1) || (x == x_position + 1 && y == y_position - 1)
     if enemy_capturable_right?
       return true
     elsif enpassant_right?
       return true
     end
    elsif (x == x_position - 1 && y == y_position + 1) || (x == x_position - 1 && y == y_position - 1)
      if enemy_capturable_left?
	return true
      elsif enpassant_left?
	return true
      end
    end
    return false if backwards_move?(y)
    return false if horizontal_move?(x)
    return false if enemy_in_front?

    normal_move?(y) || first_move?(y)
  end

  def horizontal_move?(x)
    x_diff = (x_position - x).abs
    x_diff != 0
  end

  def backwards_move?(y)
    if color == true
      y_position < y
    else
      y_position > y
    end
  end

  def starting_position?(y)
    (y_position == 1 && color == false) || (y_position == 6 && color == true)
  end

  def first_move?(y)
    y_diff = y - y_position
    if starting_position?(y)
      if color == false
	y_diff == 1 || y_diff == 2
      elsif color == true
	y_diff == -1 || y_diff == -2
      end

    else
      return false
    end
  end

  def normal_move?(y)
    (y - y_position).abs == 1
  end

  def enemy_in_front?
    in_front = false
    if color == false
      if Piece.find_by(x_position: x_position, y_position: y_position + 1, color: true, game_id: game_id) != nil
	in_front = true
      end
    elsif color == true
      if Piece.find_by(x_position: x_position, y_position: y_position - 1, color: false, game_id: game_id) != nil
	in_front = true
      end
    end
    in_front
  end

  def enemy_capturable_left?
    capturable_left = false
    if color == false
      if Piece.find_by(x_position: x_position - 1, y_position: y_position + 1, color: true, game_id: game_id) != nil
	capturable_left = true
      end
    else
      if Piece.find_by(x_position: x_position - 1, y_position: y_position - 1, color: false, game_id: game_id) != nil
	capturable_left = true
      end
    end
    capturable_left
  end

  def enemy_capturable_right?
    capturable_right = false
    if color == false
      if Piece.find_by(x_position: x_position + 1, y_position: y_position + 1, color: true, game_id: game_id) != nil
	capturable_right = true
      end
    else
      if Piece.find_by(x_position: x_position + 1, y_position: y_position - 1, color: false, game_id: game_id) != nil
	capturable_right = true
      end
    end
    capturable_right
  end

  def enpassant_left?
    piece_left =  Piece.find_by(x_position: x_position - 1, y_position: y_position, game_id: game_id)

    if piece_left == nil
      return false
    else
      if color == false
	if piece_left.last_move == 2 && piece_left.class == Pawn && piece_left.color == true
	  piece_left.destroy
	  return true
	end
      else
	if piece_left.last_move == 2 && piece_left.class == Pawn && piece_left.color == false
	  piece_left.destroy
	  return true
	end
      end
    end
  end

  def enpassant_right?
    piece_right =  Piece.find_by(x_position: x_position + 1, y_position: y_position, game_id: game_id)

    if piece_right == nil
      return false
    else
      if color == false
	if piece_right.last_move == 2 && piece_right.class == Pawn && piece_right.color == true
	  piece_right.destroy
	  return true
	end
      else
	if piece_right.last_move == 2 && piece_right.class == Pawn && piece_right.color == false
	  piece_right.destroy
	  return true
	end
      end
    end
  end
end
