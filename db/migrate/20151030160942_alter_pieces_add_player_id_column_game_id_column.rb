class AlterPiecesAddPlayerIdColumnGameIdColumn < ActiveRecord::Migration
  def change
  	add_column :pieces, :player_id, :integer
  	add_index :pieces, [:player_id, :game_id]
  end
end
