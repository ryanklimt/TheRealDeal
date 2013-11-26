class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :last_poster_id
      t.datetime :last_post_at
      t.integer :forum_id
      t.integer :user_id

      t.timestamps
    end
  end
end
