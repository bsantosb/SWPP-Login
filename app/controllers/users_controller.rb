class UsersController < ApplicationController
class UsersController < ApplicationController

  def show
    @user = User.find(params[:username])
  end

  def new
    @user = User.new
  end
end
end
