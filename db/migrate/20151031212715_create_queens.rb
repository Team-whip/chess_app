class CreateQueens < ActiveRecord::Migration
  def change
    create_table :queens do |t|

      t.timestamps null: false
    end
  end
end
