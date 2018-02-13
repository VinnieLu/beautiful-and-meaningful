get "/user/register" do
	erb :register
end

post "/user/register" do
	@validating_user = User.find_by(email: params[:email])
	if !@validating_user
		@validating_user = User.find_by(username: params[:username])
	end
	if @validating_user
		@error = "Please enter an unregistered email and username."
		erb :register
	elsif params[:email] == ""
		@error = "Please enter an email"
		erb :register
	elsif params[:username] == ""
		@error = "Please enter a username"
		erb :register
	elsif params[:password] == ""
		@error = "Please enter a password"
		erb :register
	else
		@new_user = User.create(params)
		session[:user_id] = @new_user.id
		redirect "/"
	end
end

get "/user/logout" do
	session[:user_id] = nil
	redirect "/"
end

get "/user/login" do
	erb :login
end

post "/user/login" do
	@user = User.find_by(email: params[:email])
	if @user
		if @user.password == params[:password]
			session[:user_id] = @user.id
			redirect "/"
		else
			@error = "Please enter the correct password for this email."
			erb :login
		end
	else
		@error = "Please enter a registered email."
		erb :login
	end
end

get "/user/profile/:profile_id" do
		@user = User.find_by(id: session[:user_id])
		@items = Item.where(user_id: session[:user_id])
		erb :profile
end