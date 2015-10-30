class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
    	t.integer :x_position
    	t.integer :y_position	
    	t.integer :game_id
    	t.string :type
    	t.boolean :color

      t.timestamps null: false
    end

    # add_index :pieces, [:player_id, :game_id]
    add_index :pieces, :game_id

  end
end
