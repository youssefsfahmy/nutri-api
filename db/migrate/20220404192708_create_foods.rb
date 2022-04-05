class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :picture
      t.integer :calories
      t.integer :serving

      t.timestamps
    end
  end
end
