class Game < ActiveRecord::Base
	has_many :pieces
	has_many :join_games
	has_many :joined_players, through: :join_games, source: :player
	belongs_to :players

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

	def legal_castle_move?(x, y, color)
		king = Piece.find_by(type: 'King', color: color, game_id: id)
		rook = Piece.find_by(type: 'Rook', color: color, game_id: id)

		#return false if king has moved
		#return false if rook has moved
		#there are no pieces between the king and chosen rook
		#the king is not in check, pass though check, or end in check

		return false unless (x - king.x_position).abs == 2
		return false unless y == king.y_position

		if x > king.x_position
			king_rook = Piece.find_by(x_position: 7, type: 'Rook', color: color, game_id: id)
		else
			queen_rook = Piece.find_by(x_position: 0, type: 'Rook', color: color, game_id: id)
		end

		return false if king_rook.nil?
		return false if queen_rook.nil?

		#return false unless @rook_for_castle.state == 'unmoved'

		true
	end

end
