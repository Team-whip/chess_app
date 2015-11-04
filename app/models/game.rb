class Game < ActiveRecord::Base
	has_many :pieces

	def draw_board
		# creates the 2d array 
		# Should be 8 X 8 
		# Should have white and black squares underneath that alternate

		cells = @cells

		@board = Array.new(7) { Array.new(7) }
		@board[0][0] = Pawn.create			

	end

	def populate_board
		# Populates a new board
		
		# Create white pieces
		(0..7).board.each do |i|
			Pawn.create(x_position: i, y_position: 6, game_id: id, color: white)
		end

		Rook.create(x_position: 7, y_position: 0, game_id: id, color: white)
		Rook.create(x_position: 7, y_position: 7, game_id: id, color: white)

		Knight.create(x_position: 7, y_position: 1, game_id: id, color: white)
		Knight.create(x_position: 7, y_position: 6, game_id: id, color: white)

		Bishop.create(x_position: 7, y_position: 2, game_id: id, color: white)
		Bishop.create(x_position: 7, y_position: 5, game_id: id, color: white)

		Queen.create(x_position: 7, y_position: 3, game_id: id, color: white)
		King.create(x_position: 7, y_position: 4, game_id: id, color: white)


		# Should include all the appropriate pieces for both 
		# player_white and player_black
	end

	def in_check?
		# Checks to see if either player is in check.
	end

	def in_checkmate?
		# Checks to see if either player is in checkmate.
	end

	def player_turn
		# Checks to see who's turn it is.
	end

	def check_two_players_present
		# Checks that two players are present(logged in) to play.
	end
end
