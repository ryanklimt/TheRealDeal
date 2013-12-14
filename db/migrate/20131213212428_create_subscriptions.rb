class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :subforum_id
      t.date :user_last_notified_at

      t.timestamps
    end
    add_index :subscriptions, [:subforum_id, :user_id], unique: true
  end
end
