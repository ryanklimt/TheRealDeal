class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :password_digest
      t.string :remember_token
      t.boolean :admin, default: false
      t.boolean :private, default: false
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :users, :remember_token
  end
end
