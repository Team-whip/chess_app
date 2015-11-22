class GamesController < ApplicationController
  respond_to :js, :json, :html
  before_action :authenticate_player!, only: [:new, :create]
  
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_player.games.create(game_params)
    @board = Board.new.populate(@game.id)
    current_player.join_games.create(game: @game)
    @game.update_attributes(player_one_id: current_player.id)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @pieces = Piece.where(game_id: @game.id)
    @board = Board.new
    @board.refresh(@game.id)
  end

  def select_piece
    x = params[:x]
    y = params[:y]
    piece = Piece.where(x_position: x, y_position: y, game_id: @game.id)
    @board.refresh(@game.id)
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end

end
