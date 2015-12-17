class Piece < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  def attempt_move(x, y, board, color, game_id)
    game = Game.find_by(id: game_id)
    old_x = self.x_position
    old_y = self.y_position

    if in_check(color, game_id)
      if self.class != King && self.legal_move?(x, y)
	if @enemy_making_check.is_move_obstructed?(@king.x_position, @king.y_position, board)
	  puts 1
	  return true
	else
	  self.update_attributes(x_position: old_x, y_position: old_y)
	  puts 2
	  return false
	end
      end
    end

    if self.class == King
      if game.moving_into_check?(x, y, color)
	puts 3
	return false
      else
	if game.castling_occured(x, y, color, game_id)
	  puts 4
	  self.is_move_obstructed?(x, y, board) ? false : true
	elsif self.legal_move?(x, y)
	  puts 5
	  self.is_move_obstructed?(x, y, board) ? false : true
	end
      end
    else
      if self.legal_move?(x, y)
	puts 6
	self.is_move_obstructed?(x, y, board) ? false : true
      else
	puts 7
	return false
      end
    end
  end

  def in_check(color, game_id)
    @king = Piece.find_by(type: 'King', color: color, game_id: game_id)
    check = false
    enemy_color = false
    color == true ? enemy_color = false : enemy_color = true
    enemies = Piece.where(game_id: game_id, color: enemy_color)

    enemies.each do |enemy|
      if enemy.legal_move?(@king.x_position, @king.y_position)
	@enemy_making_check = enemy
	check = true
      end
    end
    check
  end

  def is_move_obstructed?(x, y, board)
    original_x = self.x_position
    original_y = self.y_position

    if self.class == Knight
      if self.location_obstructed?(x, y, board)
	if board.board[y][x].color != self.color
	  capture(x, y, board)
	else
	  true
	end
      else
	false
      end
    else
      if x != original_x && y != original_y
	puts 'diagonal'
	if self.diagonal_path_obstructed?(x, y, board)
	  return true
	elsif check_location(x, y, board)
	  return true
	else
	  return false
	end
      elsif x != original_x && y == original_y
	puts 'horizontal'
	if self.horizontal_path_obstructed?(x, y, board)
	  return true
	elsif check_location(x, y, board)
	  return true
	else
	  return false
	end
      elsif y != original_y && x == original_x
	puts 'vertical'
	puts self.vertical_path_obstructed?(x, y, board).inspect
	if self.vertical_path_obstructed?(x, y, board)
	  puts 'path obstructed'
	  return true
	elsif check_location(x, y, board)
	  puts 'skipped path'
	  return true
	else
	  puts 'not obstructed'
	  return false
	end
      end
    end
  end

  def check_location(x, y, board)
    check = false
    if self.location_obstructed?(x, y, board)
      if board.board[y][x].color != self.color
	capture(x, y, board)
	puts 'captured'
	check = false
      else
	puts 'not captured'
	check = true
      end
    end
    check
  end


  def is_piece_on_board?
    if self.x_position == nil || self.y_position == nil
      self.alive = false
      false
    else
      self.alive = true
      true
    end
  end

  def location_obstructed?(x, y, board)
    board.board[y][x] != nil ? true : false
  end

  def diagonal_path_obstructed?(x, y, board)
    new_x = self.x_position
    new_y = self.y_position
    # pieces moving down and right diagonally
    if self.x_position < x && self.y_position < y
      while new_x < x && new_y < y do
	new_x += 1
	new_y += 1
	board.board[new_y][new_x] != nil ? (return true) : (return false)
      end
      # pieces moving down and left diagonally
    elsif self.x_position > x && self.y_position < y
      while new_x > x && new_y < y do
	new_x -= 1
	new_y += 1
	board.board[new_y][new_x] != nil ? (return true) : (return false)
      end
      # pieces moving up and right diagonally
    elsif self.x_position < x && self.y_position > y
      while new_x < x && new_y > y do
	new_x += 1
	new_y -= 1
	board.board[new_y][new_x] != nil ? (return true) : (return false)
      end
      # pieces moving up and left diagonally
    elsif self.x_position > x && self.y_position > y
      while new_x > x && new_y > y do
	new_x -= 1
	new_y -= 1
	board.board[new_y][new_x] != nil ? (return true) : (return false)
      end
    end
  end

  def vertical_path_obstructed?(x, y, board)
    new_y = self.y_position
    # pieces moving up
    if self.y_position > y
      while new_y > y do
	new_y -= 1
	board.board[new_y][self.x_position] != nil ? (return true) : (return false)
      end
      # pieces moving down
    elsif self.y_position < y
      while new_y < y do
	new_y += 1
	board.board[new_y][self.x_position] != nil ? (return true) : (return false)
      end
    end
  end

  def horizontal_path_obstructed?(x, y, board)
    new_x = self.x_position
    # pieces moving right
    if self.x_position < x
      while new_x < x do
	new_x += 1
	board.board[self.y_position][new_x] != nil ? (return true) : (return false)
      end
      # pieces moving left
    elsif self.x_position > x
      while new_x > x do
	new_x -= 1
	board.board[self.y_position][new_x] != nil ? (return true) : (return false)
      end
    end
  end

  def capture(x, y, board)
    game_id = board.board[y][x].game_id
    game = Game.find(game_id)
    game.captured_pieces(x, y, board)
    board.board[y][x].destroy
    board.board[y][x] = nil
  end

  def king_legal_move?(x, y, color, game_id)
    game = Game.find_by(id: game_id)
    if self.type == 'King'
      if game.legal_castle_move?(x, y, color, game_id)
	true
      else
	false
      end
    end
  end

end

