class Game < ActiveRecord::Base
	has_many :pieces
	has_many :join_games
	has_many :joined_players, through: :join_games, source: :player
	belongs_to :players

	def in_check?(color)
		king = Piece.find_by(type: 'King', color: color, game_id: id )
		enemies = Piece.where(color: 'true', game_id: id)
	
		enemies.each do |enemy|
      if enemy.legal_move?(king.x_position, king.y_position)
        @enemy_making_check = enemy
        return true
      end
    end
    false
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

	def legal_castle_move?(x, y, color, game_id)
		king = Piece.find_by(type: 'King', color: color, game_id: game_id)

		#return false if king has moved
		if king.color == false
			return false unless king.x_position == 4 && king.y_position == 0
		else
			return false unless king.x_position == 4 && king_y_position == 7
		end

		#there are no pieces between the king and chosen rook
		#this will be handled by pushing this through the attempt_move which checks for obstructions

		#the king is not in check
		#this will be handled by pushing this through attempt_move which checks for in_check?

		#check that intent is to castle
		return false unless (x - king.x_position).abs == 2
		return false unless y == king.y_position

		#check which side rook the castling will occur on and return false if rook has moved
		#or been captured
		if x > king.x_position
			king_rook = Piece.find_by(x_position: 7, type: 'Rook', color: color, game_id: game_id)
			return false if king_rook.nil?
			if king_rook.color == false
				return false unless king_rook.x_position == 7 && king_rook.y_position == 0
			elsif king_rook.color == true
				return false unless king_rook.x_position == 7 && king_rook.y_position == 7
			end
		elsif x < king.x_position
			queen_rook = Piece.find_by(x_position: 0, type: 'Rook', color: color, game_id: game_id)
			return false if queen_rook.nil?
			if queen_rook.color == false
				return false unless queen_rook.x_position == 0 && queen_rook.y_position == 0
			elsif queen_rook.color == true
				return false unless queen_rook.x_position == 0 && queen_rook.y_position == 7
			end
		end

		true
	end

end
