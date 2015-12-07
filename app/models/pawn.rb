class Pawn < Piece
	def legal_move?(x, y)
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
		y_diff = (y - y_position).abs
		if starting_position?(y)
			y_diff == 1 || y_diff == 2
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
end
