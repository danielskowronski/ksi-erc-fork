class CreateLockLogs < ActiveRecord::Migration
  def change
    create_table :lock_logs do |t|
      t.string :card_id

      t.timestamps null: false
    end
  end
end
