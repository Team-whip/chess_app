class JoinGamesController < ApplicationController
  before_action :authenticate_player!

  def create
    if current_game.player_one_id == current_player.id
      redirect_to :back
    elsif current_game.player_two_id == nil
      current_player.join_games.create(game: current_game)
      current_game.update_attributes(player_two_id: current_player.id)
      Board.new.populate(current_game.id, current_game.player_one_id, current_game.player_two_id)
      redirect_to game_path(current_game)
    else
      redirect_to :back, flash.now.alert = "Game Currently Full"
    end
  end

  private

  def current_game
    @current_game ||= Game.find(params[:game_id])
  end
end
