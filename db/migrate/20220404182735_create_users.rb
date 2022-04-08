class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email      
      t.string :name
      t.string :password_digest
      t.integer :caloriesperday
      t.boolean :admin
      t.integer :remainingcalories
      t.date :dateremaining
      t.timestamps
    end
  end
end
