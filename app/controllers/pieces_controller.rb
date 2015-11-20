class PiecesController < ApplicationController

	def select_piece
		#id = piece_params[:id].to_i
		#piece = Piece.where(x_position: x, y_position: y)
		
		#respond_to do |format|
		#	format.js
		#end
	end

	private

	def piece_params
		params.require(:piece).permit(:id) 
	end

end
