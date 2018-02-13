class Item < ActiveRecord::Base
	validates :name, presence: true
	validates :condition, presence: true
	validates :description, presence: true
	validates :user_id, presence: true
	validates :auction_start, presence: true
	validates :auction_end, presence: true

	belongs_to :user
	has_many :bids
	has_many :bidders, through: :bids, source: :users
end
