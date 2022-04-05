class AddRemainingcaloriesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :remainingcalories, :integer
  end
end
