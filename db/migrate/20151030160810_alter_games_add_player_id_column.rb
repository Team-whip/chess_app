class AlterGamesAddPlayerIdColumn < ActiveRecord::Migration
  def change
  	add_column :games, :player_id, :integer
  	add_index :games, :player_id
  end
end
