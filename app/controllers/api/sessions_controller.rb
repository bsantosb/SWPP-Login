class Api::SessionsController < Api::BaseController
	def create
		user= User.where(:username => params[:username], :password => params[:password]).first 
		
			if user 
				session[:user_id] = user.id 
				session[:count] = user.count += 1
				user.update_attribute(:count, session[:count])
				respond_with(user, :location => api_login_path(user), :except=> [:password, :created_at, :updated_at, :id])
			else
				
				respond_to do |format|
    				error_code= { :status => "422", :error_code => "-4" }
    				format.json  { render :json => error_code, :except=> :status  } 
  				end
				
			end
	end
end