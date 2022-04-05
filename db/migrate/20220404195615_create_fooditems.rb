class CreateFooditems < ActiveRecord::Migration[7.0]
  def change
    create_table :fooditems do |t|
      t.string :name
      t.string :picture
      t.integer :calories
      t.integer :serving

      t.timestamps
    end
  end
end
