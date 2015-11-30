class AddLifeToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :alive, :boolean, default: true
  end
end
