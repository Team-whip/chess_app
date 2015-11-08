class AddNameToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :first_name, :string
  end
end
