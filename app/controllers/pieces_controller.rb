class PiecesController < ApplicationController

  def update
    new_x = params[:new_x]
    new_y = params[:new_y]
    piece = Piece.find(params[:pieceId])
    @game_id = piece.game_id
    @board = Board.new
    @board.refresh(@game_id)
    game = Game.find(@game_id)

    if piece.player_id == current_player.id && game.turn == current_player.id
      if piece.attempt_move(new_x.to_i, new_y.to_i, @board, piece.color, @game_id)
	piece.update_attributes(x_position: new_x, y_position: new_y, moved: true)
	if game.turn == game.player_one_id
	  game.update_attributes(turn: game.player_two_id)
	else
	  game.update_attributes(turn: game.player_one_id)
	end

	render json: {
	  update_url: game_path(@game_id)
	}
      else
	flash[:warning] = "Invalid Move"

	render json: {
	  update_url: game_path(@game_id)
	}
      end
    else
      if piece.player_id != current_player.id
	flash[:warning] = "You can only move your own pieces"
      else
	flash[:warning] = "You can only move when it is your turn"
      end

      render json: {
	update_url: game_path(@game_id)
      }
    end

  end
end
