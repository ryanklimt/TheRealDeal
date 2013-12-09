class AddNewFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verify_email, :boolean, default: false
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :gender, :string, default: "Male"
    add_column :users, :birthday, :date
    add_column :users, :country, :string
    add_column :users, :status, :string
    add_column :users, :bio, :text
  end
end
