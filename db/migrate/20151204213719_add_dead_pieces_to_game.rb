class AddDeadPiecesToGame < ActiveRecord::Migration
  def change
    add_column :games, :dead_pieces, :string, array: true, default: []
  end
end
