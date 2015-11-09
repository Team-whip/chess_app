class JoinGamesController < ApplicationController
  before_action :authenticate_player!

  def create
    if current_game.player_two_id == nil
      current_player.join_games.create(game: current_game)
      current_game.update_attributes(player_two_id: current_player.id)
      redirect_to game_path(current_game)
    else
      redirect_to :back, flash[:notice] = "Game Currently Full"
    end
  end

  private

  def current_game
    @current_game ||= Game.find(params[:game_id])
  end
end
