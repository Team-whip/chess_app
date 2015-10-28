class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|

    	t.string :name
    	t.string :player_color
    	t.integer :player_turn

      t.timestamps null: false
    end

    # add index when the player class exists

  end
end
