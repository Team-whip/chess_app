class CreateJoinGames < ActiveRecord::Migration
  def change
    create_table :join_games do |t|
      t.integer :player_id
      t.integer :game_id
      t.timestamps null: false
    end

    add_index :join_games, [:player_id, :game_id]
    add_index :join_games, :game_id
  end
end
