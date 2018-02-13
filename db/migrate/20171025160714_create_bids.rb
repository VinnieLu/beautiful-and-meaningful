class CreateBids < ActiveRecord::Migration
  def change
  	create_table :bids do |k|
  		k.string :amount
  		k.integer :user_id
  		k.integer :item_id

  		k.timestamps
  	end
  end
end
