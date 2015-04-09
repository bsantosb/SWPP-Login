class SessionsController < ApplicationController
  def new
  end

    


  def create
    #user = User.find_by(username: params[:session][:username])
   #  if user && user.authenticate(params[:session][:password])

   user= User.where(:username => params[:user][:username], :password => params[:user][:password]).first 
   if user 
      session[:user_id] = user.id 
      session[:count] = user.count += 1
      user.update_attribute(:count, session[:count])
      flash[:notice] = "Signed in successfully."
      redirect_to user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to root_url
    end
  end

  def destroy
      session[:user_id] = nil
      flash[:notice] = "Signed out successfully."
      redirect_to root_url
  end

end
