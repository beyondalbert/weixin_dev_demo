class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :auth_token
      t.integer :user_type
      t.boolean :admin

      t.timestamps
    end
  end
end
