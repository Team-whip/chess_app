class AlterPiecesMovedStatusIdColumn < ActiveRecord::Migration
  def change
  	add_column :pieces, :moved, :boolean
  end
end
