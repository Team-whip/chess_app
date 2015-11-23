class Rook < Piece
	def legal_move?(x, y)
		x_position == x || y_position == y
	end
end
