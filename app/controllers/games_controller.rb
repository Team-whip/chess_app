class GamesController < ApplicationController
  #before_action :authenticate_user!
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    @board = Board.new.populate(@game.id)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @pieces = Piece.where(game_id: @game.id)
    @board = Board.new
    @board.refresh(@game.id)
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

end
