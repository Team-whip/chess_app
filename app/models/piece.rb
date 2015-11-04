class Piece < ActiveRecord::Base
	belongs_to :player
	belongs_to :game

	# Assign board size

	def is_move_obstructed?
		# Check to see if a move is obstructed
	end

	def is_a_move_on_the_board?
		# Check to make sure it is on the board?
	end

end
