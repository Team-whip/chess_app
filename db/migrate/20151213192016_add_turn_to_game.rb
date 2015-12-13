class AddTurnToGame < ActiveRecord::Migration
  def change
    remove_column :games, :player_turn, :integer
    add_column :games, :turn, :integer
  end
end
