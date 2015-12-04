class Piece < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  def attempt_move(x, y, board, color, game_id)
    game = Game.find_by(id: game_id)
    king = King.find_by(color: color, game_id: game_id)

    if self.type != 'King' && game.in_check?(color)
      return false
    else
      if self.legal_move?(x, y)
	self.is_move_obstructed?(x, y, board) ? false : true
      else
	return false
      end
    end
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
      if self.location_obstructed?(x, y, board)
	if board.board[y][x].color != self.color
	  capture(x, y, board)
	else
	  true
	end
      elsif x != original_x && y != original_y
	self.diagonal_path_obstructed?(x, y, board)
      elsif x != original_x && y == original_y
	self.horizontal_path_obstructed?(x, y, board)
      elsif y != original_y && x == original_x
	self.vertical_path_obstructed?(x, y, board)
      end
    end
  end

    def is_a_move_on_the_board?
      # Check to make sure it is on the board?
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
      board.board[y][x].destroy
      board.board[y][x] = nil
    end
  end
