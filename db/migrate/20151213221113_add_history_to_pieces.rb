class AddHistoryToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :last_move, :integer
  end
end
