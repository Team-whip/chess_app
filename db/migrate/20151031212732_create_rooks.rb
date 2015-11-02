class CreateRooks < ActiveRecord::Migration
  def change
    create_table :rooks do |t|

      t.timestamps null: false
    end
  end
end
