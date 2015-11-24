class PiecesController < ApplicationController

	def update
		new_x = params[:new_x]
		new_y = params[:new_y]
		piece = Piece.find(params[:pieceId])

		piece.update_attributes(x_position: new_x, y_position: new_y)
		redirect_to game_path(piece.game_id)
	end

end
