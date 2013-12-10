class CreateSubforums < ActiveRecord::Migration
  def change
    create_table :subforums do |t|
      t.string :name
      t.text :description
      t.integer :forum_id
      t.integer :user_id
      t.timestamps
    end
  end
end
