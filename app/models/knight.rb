class Knight < Piece
	def legal_move?(x, y)
		return false if x_position == x
		return false if y_position == y
		correct_length?(x, y)
	end

	def correct_length?(x, y)
		(x_position - x).abs + (y_position - y).abs == 3
	end
end
