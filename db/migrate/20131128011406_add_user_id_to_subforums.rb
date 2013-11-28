class AddUserIdToSubforums < ActiveRecord::Migration
  def change
    add_column :subforums, :user_id, :integer
  end
end
