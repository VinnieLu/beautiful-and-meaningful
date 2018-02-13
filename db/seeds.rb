20.times do
	user = User.create(email: Faker::Internet.safe_email, username: Faker::Lorem.words(1), password: "password")
	item = Item.create(name: Faker::Lorem.words(1)[0], condition: Faker::Lorem.sentence, description: Faker::Lorem.sentences, user_id: user.id, auction_start: "2017-10-25 13:00:00 UTC", auction_end: "2017-10-30 13:00:00 UTC")
	bid = Bid.new(amount: rand(100), user_id: user.id, item_id: item.id)
end