class PiecesController < ApplicationController
<<<<<<< HEAD
	def select_piece
		# tempid = piece_params[:id].to_i
		x = params[:x_position]
		y = params[:y_position]
		@piece = Piece.where(x_position: x, y_position: y)
		@game = Game.find(params[:id])
		@board = Board.new
		@board.refresh(@game.id)
	end

	def move_piece
		@piece = Piece.find(params[:id])
		@piece.move_piece!(params[:x_position], params[:y_position])
		@game = Game.find(params[:id])
		@board = Board.new
		@board.refresh(@game.id)
		redirect_to game_path(@piece.game_id)
	end


	private

	#single ID here ranging from 0-63 corresponding with the board.
	def piece_params
		params.require(:id).permit(:x_position, :y_position)
	end
=======
>>>>>>> 30f1bb3bbfc8b2aea0bf58623485f1cce7e5b697

end
