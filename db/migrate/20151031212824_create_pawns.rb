class CreatePawns < ActiveRecord::Migration
  def change
    create_table :pawns do |t|

      t.timestamps null: false
    end
  end
end
