class Game < ActiveRecord::Base
	has_many :pieces

	def draw_board
	  @new_board = Board.new
	end
	
	def populate_board
	  self.draw_board
	  @new_board.populate
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
