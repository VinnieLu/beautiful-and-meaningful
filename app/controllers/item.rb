get "/item/create" do
	if session[:user_id]
		erb :create_item
	else
		redirect "/user/login"
	end
end

post "/item/create" do
	@item = Item.new(params)
	@item.user_id = session[:user_id]
	if @item.valid?
		@item.save!
		redirect "/user/profile/#{session[:user_id]}"
	else
		@error = "Please fill in all fields"
		erb :create_item
	end
end

get "/item/edit/:item_id" do
	@item = Item.find_by(id: params[:item_id])
	if session[:user_id]
		if session[:user_id] == @item.user_id
			erb :edit_item
		else
			@error = "This is not your item"
			@user = User.find_by(id: session[:user_id])
			@items = Item.where(user_id: session[:user_id])
			erb :profile
		end
	else
		redirect "/user/login"
	end
end

post "/item/edit/:item_id" do
	@item = Item.find_by(id: params[:item_id])
	@item.update(name: params[:name], condition: params[:condition], description: params[:description], auction_start: params[:auction_start], auction_end: params[:auction_end])
	if @item.valid?
		@item.save!
		redirect "/user/profile/#{session[:user_id]}"
	else
		@error = "Please fill in all fields"
		erb :edit_item
	end
end

get "/item/delete/:item_id" do
	@item = Item.find_by(id: params[:item_id])
	@item.destroy
	redirect "/user/profile/#{session[:user_id]}"
end

get "/item/details/:item_id" do
	if session[:user_id]
		@item = Item.find_by(id: params[:item_id])
		@bid_count = Bid.where(item_id: params[:item_id]).count
		erb :item_details
	else
		@error = "Please log in to view item details."
		erb :login
	end
end

post "/item/bid/:item_id" do
	@bid_count = Bid.where(item_id: params[:item_id]).count
	if params[:amount].to_i <= 0 || params[:amount] == ""
		@error = "Please enter a bid greater than 0."
		@item = Item.find_by(id: params[:item_id])
		erb :item_details
	else
		@bid_validation = Bid.find_by(user_id: session[:user_id], item_id: params[:item_id])
		@item = Item.find_by(id: params[:item_id])
		if @bid_validation
			@duplicate_bid = 1
			@bid_validation
			erb :item_details
		else
			@successful_bid = Bid.create(amount: params[:amount], user_id: session[:user_id], item_id: params[:item_id])
			@bid_count = Bid.where(item_id: params[:item_id]).count
			erb :item_details
		end
	end
end