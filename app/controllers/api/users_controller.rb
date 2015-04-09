class Api::UsersController < Api::BaseController
	
	def create
  		@user = User.new(user_params)
 		
 		if @user.save
 			@user.update_attribute(:count, 1)
    		respond_with(@user, :location => api_signup_path(@user), :except=> [:password, :created_at, :updated_at, :id])
  		else
  			e = 0
  			@user.errors.full_messages.each do |msg| 

				if msg == "Username is too short (minimum is 5 characters)"
					e = "-1"
				end
				
				if msg == "Username is too long (maximum is 20 characters)"
					e = "-1"
				end

				if msg == "Password is too short (minimum is 8 characters)"
					e = "-2"
				end

				if msg == "Password is too long (maximum is 20 characters)"
					e = "-2"
				end

				if msg == "Username has already been taken"
					e = "-3"
				end
				
				
			end
			respond_to do |format|
    			error_code= { :status => "422", :error_code => e }
    			format.json  { render :json => error_code, :except=> :status  } 
  			end
  		end
	end

	def show
		@user = User.find(params[:id])
		render :json => @user
	end
	def destroy
		User.find_each(&:destroy)
		session[:user_id] = nil
		respond_to do |format|
    		error_code= { :status => "404" }
    		format.json  { render :json => error_code } 
  		end
  	end

	private 
  	def user_params
  		params.require(:user).permit(:username, :password, :count)

  	end
end