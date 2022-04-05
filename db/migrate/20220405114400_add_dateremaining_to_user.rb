class AddDateremainingToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :dateremaining, :date
  end
end
