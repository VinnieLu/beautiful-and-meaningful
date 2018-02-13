class CreateUser < ActiveRecord::Migration
  def change
  	create_table :users do |k|
  		k.string :email
  		k.string :username
  		k.string :password_hash

  		k.timestamps
  	end
  end
end
