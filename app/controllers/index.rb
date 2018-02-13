get "/" do
	@items = Item.all
	erb :index
end

get "/tweets" do
	@tweets = $client.user_timeline.map { |tweet| tweet.text }
	erb :tweets
end

post "/charge" do
	Stripe.api_key = ENV['STRIPE_KEY']
	token = params[:stripeToken]
	@charge = Stripe::Charge.create(
	  :amount => 1000,
	  :currency => "usd",
	  :description => "Example charge",
	  :source => token,
	)
	erb :receipt
end

get "/spotify" do
	erb :spotify
end