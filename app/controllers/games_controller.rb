class GamesController < ApplicationController
  respond_to :js, :json, :html
  before_action :authenticate_player!, only: [:new, :create]

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @pieces = Piece.where(game_id: @game.id)
    unless @game.player_two_id == nil
      @player_one = Player.find(@game.player_one_id)
      @player_two = Player.find(@game.player_two_id)
    end
    @board = Board.new
    @board.refresh(@game.id)
  end

  def new
    @game = Game.new
  end

  def create
    @game = current_player.games.create(game_params)
    current_player.join_games.create(game: @game)
    @game.update_attributes(player_one_id: current_player.id, turn: current_player.id)
    redirect_to game_path(@game)
  end


  private

  def game_params
    params.require(:game).permit(:name)
  end

end
