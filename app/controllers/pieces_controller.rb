class PiecesController < ApplicationController
	def select_piece
		id = piece_params[:id].to_i
		piece = Piece.where(x_position: x, y_position: y, game_id: @game.id)
	end

	private

	#single ID here ranging from 0-63 corresponding with the board.
	def piece_params
		params.require(:piece).permit(:id) 
	end

end
