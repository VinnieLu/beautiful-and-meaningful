class CreateItems < ActiveRecord::Migration
  def change
  	create_table :items do |k|
  		k.string :name
  		k.string :condition
  		k.string :description
  		k.integer :user_id
  		k.datetime :auction_start
  		k.datetime :auction_end

  		k.timestamps
  	end
  end
end
