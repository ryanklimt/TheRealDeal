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
      t.string :auth_token
      t.string :email_auth_token
      t.boolean :verify_email, default: false
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.string :city
      t.string :state
      t.string :gender
      t.date :birthday
      t.string :country
      t.string :status
      t.text :bio
      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :users, :remember_token
  end
end
