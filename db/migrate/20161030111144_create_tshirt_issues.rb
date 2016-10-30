class CreateTshirtIssues < ActiveRecord::Migration
  def change
    create_table :tshirt_issues do |t|
      t.string :comment
      t.belongs_to :member, index: true, foreign_key: true
      t.belongs_to :tshirt_definition, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
