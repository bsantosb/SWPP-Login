class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
      @user = User.new(user_params)
    
      if @user.save
        @user.update_attribute(:count, 1)
        session[:user_id] = @user.id
        flash[:notice] = "You have signed up successfully."
        redirect_to @user
      else
        @user.errors.full_messages.each do |msg| 

        if msg == "Username is too short (minimum is 5 characters)"
          flash[:errors] = "Error Code: -1 Username is too short."
        end
        
        if msg == "Username is too long (maximum is 20 characters)"
          flash[:error] = "Error Code: -1 Username is too long."
        end

        if msg == "Password is too short (minimum is 8 characters)"
          flash[:error] = "Error Code: -2 Password is too short."
        end

        if msg == "Password is too long (maximum is 20 characters)"
          flash[:error] = "Error Code: -2 Password is too long."
        end

        if msg == "Username has already been taken"
          flash[:error] = "Error Code: -3 Username has already been taken."
        end
      end
      redirect_to root_url
    end
 
  end

  #def destroy  
   # User.find(params[:id]).destroy
    #flash.now[:danger] = 'CLEAR DATA'
    # Redirect to login_path
  #end

  
  def destroy
    User.find_each(&:destroy)
    session[:user_id] = nil
    redirect_to root_url
  end

    private

  def user_params
      params.require(:user).permit(:username, :password, :count)
  end

end
