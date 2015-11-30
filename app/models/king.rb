class King < Piece
	def legal_move?(x, y)
		normal_move(x, y) || legal_castle_move?(x, y)
	end

	def legal_castle_move?(x, y)
		return false unless state == 'unmoved'
		return false unless (x - x_position).abs == 2
		return false unless y == y_position

		if x > x_position
			@rook_for_castle = rook_for_castling('King')
			@new_king_x = 6
			@new_rook_x = 5
		else
			@rook_for_castle = rook_for_castling('Queen')
			@new_king_x = 2
			@new_rook_x = 3
		end

		return false if @rook_for_castle.nil?

		return false unless @rook_for_castle.state == 'unmoved'

		true
	end
	
  private

  def normal_move(x, y)
    x_diff = (x - x_position).abs
    y_diff = (y - y_position).abs

    (x_diff <= 1) && (y_diff <= 1)
  end
end
