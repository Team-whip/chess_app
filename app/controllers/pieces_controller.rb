class PiecesController < ApplicationController

  def update
    new_x = params[:new_x]
    new_y = params[:new_y]
    piece = Piece.find(params[:pieceId])
    @game_id = piece.game_id

    piece.update_attributes(x_position: new_x, y_position: new_y)

    render json: {
      update_url: game_path(@game_id)
    }
    
  end

end
