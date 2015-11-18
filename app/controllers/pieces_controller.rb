class PiecesController < ApplicationController
	def select_piece
		id = piece_params[:id].to_i
		x = id % 8
		y = id / 8
		piece = Piece.where(x_position: x, y_position: y)
		redirect_to game_path(@game)
	end

	private

	def piece_params
		params.require(:piece).permit(:id) 
	end

end
