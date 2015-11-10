class AddPlayerColorAndIdToGame < ActiveRecord::Migration
  def change
    add_column :games, :player_one_id, :integer
    add_column :games, :player_two_id, :integer
    add_column :games, :player_one_color, :boolean, default: true
    add_column :games, :player_two_color, :boolean, default: false
    remove_column :games, :player_color, :string
  end
end
