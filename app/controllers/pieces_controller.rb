class PiecesController < ApplicationController
  skip_before_filter :verify_authenticity_token, if: :json_request?

  def update
    new_x = params[:new_x]
    new_y = params[:new_y]
    piece = Piece.find(params[:pieceId])
    @game_id = piece.game_id
    @board = Board.new
    @board.refresh(@game_id)

    if piece.attempt_move(new_x.to_i, new_y.to_i, @board, piece.color, @game_id)
      piece.update_attributes(x_position: new_x, y_position: new_y, moved: true)

      render json: {
	update_url: game_path(@game_id)
      }
    else
     flash[:warning] = "Invalid Move"

     render json: {
       update_url: game_path(@game_id)
     }
    end

  end

  protected

  def json_request?
    request.format.json?
  end

end
