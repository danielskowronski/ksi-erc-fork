class CreateTshirtDefinitions < ActiveRecord::Migration
  def change
    create_table :tshirt_definitions do |t|
      t.string :name
      t.string :produced
      t.string :comments
      t.string :image

      t.timestamps null: false
    end
  end
end
