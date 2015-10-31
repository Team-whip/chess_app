class Game < ActiveRecord::Base
	has_many :pieces

	def create_board
		# Instantiate's a new board. 
		# Should be 8 X 8 
		# Should include all the appropriate pieces for both 
		# player_white and player_black
		# Should have white and black squares underneath that alternate
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
